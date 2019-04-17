//
//  RoboticsConfigurationServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsConfigurationServiceInterface {
    func updateFirmware(with file: URL, onSuccess: Callback?, onError: ErrorCallback?)
    func updateFramework(with file: URL, onSuccess: Callback?, onError: ErrorCallback?)
    func testKit(with file: URL, onSuccess: Callback?, onError: ErrorCallback?)
    func sendConfiguration(with file: URL, onSuccess: Callback?, onError: ErrorCallback?)
    func changeName(with name: String, onSuccess: Callback?, onError: ErrorCallback?)
}
