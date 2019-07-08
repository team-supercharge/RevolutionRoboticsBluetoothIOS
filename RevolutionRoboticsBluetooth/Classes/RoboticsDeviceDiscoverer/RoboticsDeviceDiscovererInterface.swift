//
//  RoboticsDeviceDiscovererInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import enum CoreBluetooth.CBManagerState

public protocol RoboticsDeviceDiscovererInterface {
    var bluetoothRadioState: CBManagerState { get }
    func discoverRobots(onScanResult: CallbackType<[Device]>?, onError: CallbackType<Error>?)
    func stopDiscover()
}
