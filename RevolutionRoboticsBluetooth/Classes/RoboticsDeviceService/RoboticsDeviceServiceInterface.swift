//
//  RoboticsDeviceServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsDeviceServiceInterface {
    func getSerialNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
    func getManufacturerName(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
    func getHardwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
    func getSoftwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
    func getFirmwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
    func getSystemId(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
    func getModelNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
}
