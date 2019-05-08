//
//  RoboticsDeviceConnector.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsDeviceConnector {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    public init() {
    }
}

// MARK: - RoboticsDeviceConnectorInterface
extension RoboticsDeviceConnector: RoboticsDeviceConnectorInterface {
    public func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?) {
        bluetoothController.connect(to: device, onConnected: onConnected, onDisconnected: onDisconnected, onError: onError)
    }

    public func disconnect() {
        bluetoothController.disconnect()
    }
}
