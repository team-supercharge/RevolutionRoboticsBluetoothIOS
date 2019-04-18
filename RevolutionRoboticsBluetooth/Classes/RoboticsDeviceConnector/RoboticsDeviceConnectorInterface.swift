//
//  RoboticsDeviceConnectorInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsDeviceConnectorInterface {
    func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?)
    func disconnect()
}
