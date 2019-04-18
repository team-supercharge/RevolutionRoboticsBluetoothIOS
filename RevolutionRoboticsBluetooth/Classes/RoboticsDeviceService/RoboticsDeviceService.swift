//
//  RoboticsDeviceService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsDeviceService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared
}

// MARK: - RoboticsDeviceServiceInterface
extension RoboticsDeviceService: RoboticsDeviceServiceInterface {
    public func getSerialNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }

    public func getManufacturerName(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }

    public func getHardwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }

    public func getSoftwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }

    public func getFirmwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }

    public func getSystemId(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }

    public func getModelNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
    }
}
