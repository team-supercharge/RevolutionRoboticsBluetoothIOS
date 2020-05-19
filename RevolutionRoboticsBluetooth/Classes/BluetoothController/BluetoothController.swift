//
//  BluetoothController.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation
import CoreBluetooth
import CryptoSwift
import os

final class BluetoothController: NSObject {
    // MARK: - Constants
    private enum Constants {
        static let requiredRobotServiceIDs: [CBUUID] = [
            CBUUID(string: ServiceId.liveMessage),
            CBUUID(string: ServiceId.longMessage)
        ]
    }

    // MARK: - Properties
    private var bluetoothManager: CBCentralManager!
    private var discoveredPeripherals: Set<CBPeripheral> = Set<CBPeripheral>()
    private var discoveredDevices: [Device] = []
    private var connectedPeripheral: CBPeripheral?
    private var discoverCallback: CallbackType<[Device]>?
    private var onDeviceConnected: Callback?
    private var onDeviceDisconnected: Callback?
    private var onDeviceConnectionError: CallbackType<Error>?
    private var callbackDictionary: [String: CallbackType<Data?>] = [:]
    private var counter: UInt8 = 0
    private let processor: LongMessageProcessor = LongMessageProcessor()
    private var shouldReconnect = true
    private var serviceCount = 0

    static let shared = BluetoothController()

    var bluetoothRadioState: CBManagerState {
        return bluetoothManager.state
    }

    // MARK: - Initialization
    override private init() {
        super.init()
        self.bluetoothManager = CBCentralManager(delegate: self, queue: nil)
    }
}

// MARK: - BluetoothControllerInterface
extension BluetoothController: BluetoothControllerInterface {
    func read(from characteristic: String, serviceId: String, onComplete: CallbackType<Data?>?, onError: CallbackType<Error>?) {
        guard bluetoothManager.state == .poweredOn else {
            onError?(BluetoothControllerError.bluetoothIsNotPoweredOn)
            return
        }

        guard let peripheralCharacteristic = connectedPeripheral?.services?
            .first(where: { $0.uuid == CBUUID(string: serviceId) })?
            .characteristics?
            .first(where: { $0.uuid == CBUUID(string: characteristic) }) else {
                onError?(BluetoothControllerError.invalidServiceOrCharacteristic)
                return
        }

        callbackDictionary[peripheralCharacteristic.uuid.uuidString] = onComplete
        connectedPeripheral?.readValue(for: peripheralCharacteristic)
    }

    func write(liveController: LiveControllerDataModel) {
        var array: [UInt8] = [UInt8](repeating: 0, count: 20)
        if counter == .max {
            counter = .min
        } else {
            counter += 1
        }
        array[0] = counter
        array[1] = UInt8(liveController.xDirection)
        array[2] = UInt8(liveController.yDirection)
        array[11] = buttonStates(array: liveController.buttonStates)
        guard let peripheralCharacteristic = connectedPeripheral?.services?
            .first(where: { $0.uuid == CBUUID(string: ServiceId.liveMessage) })?
            .characteristics?
            .first(where: { $0.uuid == CBUUID(string: RoboticsLiveControllerServiceCharacteristic.periodicControllerMessage) }) else {
                return
        }
        connectedPeripheral?.writeValue(Data(array), for: peripheralCharacteristic, type: .withResponse)
    }

    private func buttonStates(array: [Bool]) -> UInt8 {
        var mask: UInt8 = 0
        array.enumerated().forEach { (offset, element) in
            if element {
                mask += 1 << offset
            }
        }
        return mask
    }

    func discover(discoveredDevices: CallbackType<[Device]>?, onError: CallbackType<Error>?) {
        self.discoveredPeripherals = Set<CBPeripheral>()
        self.discoverCallback = nil
        guard bluetoothManager.state == .poweredOn else {
            onError?(BluetoothControllerError.bluetoothIsNotPoweredOn)
            return
        }
        discoverCallback = discoveredDevices
        bluetoothManager.scanForPeripherals(withServices: Constants.requiredRobotServiceIDs, options: nil)
    }

    func stopDiscover() {
        bluetoothManager.stopScan()
        discoveredDevices = []
    }

    func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?) {
        guard let selectedPeripheral = discoveredPeripherals.first(where: { $0.identifier == UUID(uuidString: device.id) }) else {
            return
        }
        if let connectedPeripheral = connectedPeripheral {
            bluetoothManager.cancelPeripheralConnection(connectedPeripheral)
            self.connectedPeripheral = nil
            onDeviceConnected = nil
            onDeviceDisconnected = nil
            onDeviceConnectionError = nil
            self.shouldReconnect = false
        }

        bluetoothManager.connect(selectedPeripheral, options: nil)
        connectedPeripheral = selectedPeripheral
        onDeviceConnected = onConnected
        onDeviceDisconnected = onDisconnected
        onDeviceConnectionError = onError
    }

    func disconnect() {
        guard let connectedPeripheral = connectedPeripheral else { return }
        
        bluetoothManager.cancelPeripheralConnection(connectedPeripheral)
        self.connectedPeripheral = nil
        self.shouldReconnect = false
    }

    func writeSystemId(data: Data, onComplete: Callback?, onError: CallbackType<Error>?) {
        guard let deviceCharacteristic = connectedPeripheral?.services?
            .first(where: { $0.uuid == CBUUID(string: ServiceId.deviceInformationService) })?
            .characteristics?
            .first(where: { $0.uuid == CBUUID(string: RoboticsDeviceServiceCharacteristic.systemId) }) else {
                return
        }
        
        connectedPeripheral?.writeValue(data, for: deviceCharacteristic, type: .withResponse)
    }
    
    func write(data: LongMessageData, onComplete: Callback?, onError: CallbackType<Error>?) {
        guard let peripheralCharacteristic = connectedPeripheral?.services?
            .first(where: { $0.uuid == CBUUID(string: ServiceId.longMessage) })?
            .characteristics?
            .first(where: { $0.uuid == CBUUID(string: LongMessageCharacteristic.longMessage) }) else {
                return
        }

        processor.start(connectedPeripheral: connectedPeripheral!,
                        characteristic: peripheralCharacteristic,
                        data: data,
                        onComplete: onComplete,
                        onError: onError)
    }

    func stopWrite() {
        guard processor.isWriteInProgress else { return }

        processor.stop()
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            if let peripheral = connectedPeripheral, shouldReconnect {
                central.connect(peripheral, options: nil)
            }
        case .unknown, .resetting, .unsupported, .unauthorized, .poweredOff:
            os_log("Bluetooth is not powered on!")
        @unknown default:
            os_log("Unforseen bluetooth radio state!")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
            discoveredPeripherals.insert(peripheral)
            peripheral.delegate = self
            if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
                discoveredDevices.append(Device(id: peripheral.identifier.uuidString, name: name))
            } else {
                discoveredDevices.append(Device(id: peripheral.identifier.uuidString,
                                                name: peripheral.name ?? "Revolution Robotics Brain"))
            }
            discoverCallback?(discoveredDevices)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        shouldReconnect = true
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        guard let error = error else { return }
        onDeviceConnectionError?(error)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            onDeviceConnectionError?(error)
        } else {
            onDeviceDisconnected?()
        }
        if shouldReconnect {
            central.connect(peripheral, options: nil)
        }
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            os_log("Error while discovering services!")
        } else {
            peripheral.services?.forEach({ service in
                peripheral.discoverCharacteristics(nil, for: service)
            })
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        if error != nil {
            os_log("Error while discovering characteristics!")
        } else {
            guard let characteristics = service.characteristics, !characteristics.isEmpty else { return }
            if serviceCount == Constants.requiredRobotServiceIDs.count - 1 {
                onDeviceConnected?()
                serviceCount = 0
                onDeviceConnected = nil
            } else {
                serviceCount += 1
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            os_log("Error while updating value!")
        }
        
        if processor.isWriteInProgress {
            guard let response = LongMessageReadResponse(data: characteristic.value) else { return }
            processor.next(response)
        } else {
            let dataClosure = callbackDictionary[characteristic.uuid.uuidString]
            dataClosure?(characteristic.value)
            callbackDictionary.removeValue(forKey: characteristic.uuid.uuidString)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            os_log("Error while writing value!")
        } else {
            if processor.isWriteInProgress {
                processor.next()
            }
        }
    }
}
