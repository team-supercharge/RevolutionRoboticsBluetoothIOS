//
//  RoboticsConfigurationServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsConfigurationServiceInterface {
    func updateFirmware(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)
    func updateFramework(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)
    func testKit(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)
    func sendConfiguration(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)
    func stopWrite()
}
