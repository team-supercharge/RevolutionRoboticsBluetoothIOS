//
//  RoboticsMotorService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsMotorService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    // MARK: - Initialization
    public init() {
    }
}

// MARK: - RoboticsMotorServiceInterface
extension RoboticsMotorService: RoboticsMotorServiceInterface {
    public func read(id: Int, onSuccess: CallbackType<Data?>?, onError: CallbackType<Error>?) {
        bluetoothController.read(from: characteristic(for: id),
                                 serviceId: ServiceId.liveMessage,
                                 onComplete: onSuccess,
                                 onError: onError)
    }
}

// MARK: - Private methods
extension RoboticsMotorService {
    private func characteristic(for id: Int) -> String {
        switch id {
        case 1:
            return RoboticsMotorServiceCharacteristic.readMotor1
        case 2:
            return RoboticsMotorServiceCharacteristic.readMotor2
        case 3:
            return RoboticsMotorServiceCharacteristic.readMotor3
        case 4:
            return RoboticsMotorServiceCharacteristic.readMotor4
        case 5:
            return RoboticsMotorServiceCharacteristic.readMotor5
        case 6:
            return RoboticsMotorServiceCharacteristic.readMotor6
        default:
            return ""
        }
    }
}
