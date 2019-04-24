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
}

// MARK: - RoboticsMotorServiceInterface
extension RoboticsMotorService: RoboticsMotorServiceInterface {
    public func read(id: Int, onSuccess: CallbackType<MotorInfo>?, onError: CallbackType<Error>?) {
    }
}
