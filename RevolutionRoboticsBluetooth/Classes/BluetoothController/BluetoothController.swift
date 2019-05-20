//
//  BluetoothController.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation
import CoreBluetooth

final class BluetoothController: NSObject {
    // MARK: - Constants
    private enum Constants {
        static let robotServiceIds: [CBUUID] = [
            CBUUID(string: ServiceId.deviceInformationService),
            CBUUID(string: ServiceId.batteryService),
            CBUUID(string: ServiceId.liveMessage),
            CBUUID(string: ServiceId.longMessage)
        ]
    }

    // MARK: - Properties
    private var bluetoothManager: CBCentralManager!
    private var discoveredPeripherals: Set<CBPeripheral> = Set<CBPeripheral>()
    private var connectedPeripheral: CBPeripheral?
    private var discoverCallback: CallbackType<[Device]>?
    private var onDeviceConnected: Callback?
    private var onDeviceDisconnected: Callback?
    private var onDeviceConnectionError: CallbackType<Error>?
    private var callbackDictionary: [String: CallbackType<Data?>] = [:]
    private var counter: UInt8 = 0

    static let shared = BluetoothController()

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

        print("🔹 Read initiated on \(characteristic) for \(serviceId)")
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
        print("🔹 Discovery started!")
        bluetoothManager.scanForPeripherals(withServices: Constants.robotServiceIds, options: nil)
    }

    func stopDiscover() {
        bluetoothManager.stopScan()
        print("🔹 Discovery stopped!")
    }

    func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?) {
        guard let selectedPeripheral = discoveredPeripherals.first(where: { $0.identifier == UUID(uuidString: device.id) }) else {
            return
        }
        print("🔹 Connection initiated for \(selectedPeripheral.name ?? "Unknonwn Name")!")
        bluetoothManager.connect(selectedPeripheral, options: nil)
        connectedPeripheral = selectedPeripheral
        onDeviceConnected = onConnected
        onDeviceDisconnected = onDisconnected
        onDeviceConnectionError = onError
    }

    func disconnect() {
        guard let connectedPeripheral = connectedPeripheral else { return }
        print("🔹 Disconnect initiated for \(connectedPeripheral.name ?? "Unknonwn Name")!")
        bluetoothManager.cancelPeripheralConnection(connectedPeripheral)
        self.connectedPeripheral = nil
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("🔹 Bluetooth state updated to: .unknown!")
        case .resetting:
            print("🔹 Bluetooth state updated to: .resetting!")
        case .unsupported:
            print("🔹 Bluetooth state updated to: .unsupported!")
        case .unauthorized:
            print("🔹 Bluetooth state updated to: .unauthorized!")
        case .poweredOff:
            print("🔹 Bluetooth state updated to: .poweredOff!")
        case .poweredOn:
            print("🔹 Bluetooth state updated to: .poweredOn!")
            if let peripheral = connectedPeripheral {
                print("🔹 Trying to reconnecto to previously connected: \(peripheral.name ?? "Unknown device")!")
                central.connect(peripheral, options: nil)
            }
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("🔹 Discovered a peripheral - \(peripheral.name ?? "Unknonwn name")")
        if !discoveredPeripherals.contains(peripheral) {
            print("🔹 Added peripheral to discovered peripherals!")
            discoveredPeripherals.insert(peripheral)
            peripheral.delegate = self
            let devices = discoveredPeripherals.map({ Device(id: $0.identifier.uuidString, name: $0.name ?? "Unknown device") })
            discoverCallback?(devices)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("🔹 Peripheral \(peripheral.name ?? "Unknown device") successfully connected!")
        print("🔹 Peripheral \(peripheral.name ?? "Unknown device") service discovery initiated!")
        onDeviceConnected?()
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("⚠️ Peripheral \(peripheral.name ?? "Unknown device") failed to connect!")
        guard let error = error else { return }
        onDeviceConnectionError?(error)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") disconnect failed - \(error.localizedDescription)!")
            onDeviceConnectionError?(error)
        } else {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") successfully disconnected!")
            onDeviceDisconnected?()
        }

        print("🔹 Trying to reconnect to \(peripheral.name ?? "Unknown device")!")
        central.connect(peripheral, options: nil)
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") service discovery failed - \(error.localizedDescription)")
        } else {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") service discovery successfully finished!")
            peripheral.services?.forEach({ service in
                print("🔹 Peripheral \(peripheral.name ?? "Unknown device") characteristic discovery for \(service.uuid.uuidString) service initiated!")
                peripheral.discoverCharacteristics(nil, for: service)
            })
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        if let error = error {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") characteristic discovery failed - \(error.localizedDescription)")
        } else {
            guard let characteristics = service.characteristics else { return }
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") characteristic discovery successfully finished!")
            print("🔹 Characteristics for \(service.uuid.uuidString): ")
            characteristics.enumerated().forEach({ (index, characteristic) in
                print("🔹 - #\(index) - \(characteristic.uuid.uuidString)")
            })
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("🔹 Peripheral \(peripheral.name ?? "Unknown device") didUpdateValue delegate called!")
        if let error = error {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") update value failed - \(error.localizedDescription)")
        }
        print("🔹 Peripheral \(peripheral.name ?? "Unknown device") update value successfull")
        let dataClosure = callbackDictionary[characteristic.uuid.uuidString]
        dataClosure?(characteristic.value)
        callbackDictionary.removeValue(forKey: characteristic.uuid.uuidString)
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("🔹 Peripheral \(peripheral.name ?? "Unknown device") didWriteValueFor successfull")
        }
    }
}
