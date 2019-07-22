//
//  RoboticsDeviceConnectorInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsDeviceConnectorInterface {
    /// Initiate connection to a device.
    ///
    /// - Parameters:
    ///   - device: The selected device.
    ///   - onConnected: Callback when the connection operation is successful.
    ///   - onDisconnected: Callback when the device is disconnected.
    ///   - onError: Error callback if the operation fails to complete.
    func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?)

    /// Disconnect from connected device.
    func disconnect()
}
