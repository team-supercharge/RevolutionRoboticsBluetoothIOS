//
//  RoboticsDeviceDiscoverer.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation
import enum CoreBluetooth.CBManagerState

public final class RoboticsDeviceDiscoverer {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    public var bluetoothRadioState: CBManagerState {
        return bluetoothController.bluetoothRadioState
    }

    public init() {
    }
}

// MARK: - RoboticsDeviceDiscovererInterface
extension RoboticsDeviceDiscoverer: RoboticsDeviceDiscovererInterface {
    public func discoverRobots(onScanResult: CallbackType<[Device]>?, onError: CallbackType<Error>?) {
        bluetoothController.discover(discoveredDevices: onScanResult, onError: onError)
    }

    public func stopDiscover() {
        bluetoothController.stopDiscover()
    }
}
