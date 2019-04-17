//
//  RoboticsDeviceServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsDeviceServiceInterface {
    func getSerialNumber(onCompleted: StringCallback?, onError: ErrorCallback?)
    func getManufacturerName(onCompleted: StringCallback?, onError: ErrorCallback?)
    func getHardwareRevision(onCompleted: StringCallback?, onError: ErrorCallback?)
    func getSoftwareRevision(onCompleted: StringCallback?, onError: ErrorCallback?)
    func getFirmwareRevision(onCompleted: StringCallback?, onError: ErrorCallback?)
    func getSystemId(onCompleted: StringCallback?, onError: ErrorCallback?)
    func getModelNumber(onCompleted: StringCallback?, onError: ErrorCallback?)
}
