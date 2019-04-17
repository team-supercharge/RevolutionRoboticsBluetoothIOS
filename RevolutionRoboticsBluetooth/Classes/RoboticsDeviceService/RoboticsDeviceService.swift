//
//  RoboticsDeviceService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsDeviceService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController()
}

// MARK: - RoboticsDeviceServiceInterface
extension RoboticsDeviceService: RoboticsDeviceServiceInterface {
    public func getSerialNumber(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }

    public func getManufacturerName(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }

    public func getHardwareRevision(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }

    public func getSoftwareRevision(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }

    public func getFirmwareRevision(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }

    public func getSystemId(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }

    public func getModelNumber(onCompleted: StringCallback?, onError: ErrorCallback?) {
    }
}
