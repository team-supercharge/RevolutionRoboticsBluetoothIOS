//
//  RoboticsDeviceDiscoverer.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsDeviceDiscoverer {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController()
}

// MARK: - RoboticsDeviceDiscovererInterface
extension RoboticsDeviceDiscoverer: RoboticsDeviceDiscovererInterface {
    public func discoverRobots(onScanResult: DeviceArrayCallback?, onError: ErrorCallback?) {
    }

    public func stopDiscover() {
    }
}
