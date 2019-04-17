//
//  RoboticsMotorService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsMotorService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController()
}

// MARK: - RoboticsMotorServiceInterface
extension RoboticsMotorService: RoboticsMotorServiceInterface {
    public func read(id: Int, onSuccess: MotorInfoCallback?, onError: ErrorCallback?) {
    }
}
