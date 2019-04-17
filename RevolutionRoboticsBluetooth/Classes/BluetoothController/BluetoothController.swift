//
//  BluetoothController.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation
import CoreBluetooth

enum BluetoothControllerError: Error {
    case bluetoothIsNotPoweredOn
}

final class BluetoothController: NSObject {
    // MARK: - Properties
    private var bluetoothManager: CBCentralManager!
    private var discoveredPeripherals: Set<CBPeripheral> = Set<CBPeripheral>()

    // MARK: - Initialization
    override init() {
        super.init()
        self.bluetoothManager = CBCentralManager(delegate: self, queue: nil)
    }
}

// MARK: - BluetoothControllerInterface
extension BluetoothController: BluetoothControllerInterface {
    func readData(from characteristiic: String,
                  on serviceId: String,
                  onComplete: StringCallback?,
                  onError: ErrorCallback?) {
        guard bluetoothManager.state == .poweredOn else {
            onError?(BluetoothControllerError.bluetoothIsNotPoweredOn)
            return
        }
    }

    func discover(discoveredDevices: StringArrayCallback?, onError: ErrorCallback?) {
        bluetoothManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        discoveredPeripherals.insert(peripheral)
    }
}
