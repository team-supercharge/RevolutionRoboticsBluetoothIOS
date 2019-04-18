//
//  RoboticsDeviceDiscovererInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsDeviceDiscovererInterface {
    func discoverRobots(onScanResult: CallbackType<[Device]>?, onError: CallbackType<Error>?)
    func stopDiscover()
}
