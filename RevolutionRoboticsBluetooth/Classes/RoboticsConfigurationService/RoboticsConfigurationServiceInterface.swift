//
//  RoboticsConfigurationServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsConfigurationServiceInterface {
    func updateFirmware(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?)
    func updateFramework(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?)
    func testKit(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?)
    func sendConfiguration(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?)
    func changeName(with name: String, onSuccess: Callback?, onError: CallbackType<Error>?)
}
