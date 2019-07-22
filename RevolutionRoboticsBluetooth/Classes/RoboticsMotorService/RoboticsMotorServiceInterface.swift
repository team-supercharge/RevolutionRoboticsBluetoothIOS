//
//  RoboticsMotorServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsMotorServiceInterface {
    /// Read data from the given motor.
    ///
    /// - Parameters:
    ///   - id: ID of the motor.
    ///   - onSuccess: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func read(id: Int, onSuccess: CallbackType<Data?>?, onError: CallbackType<Error>?)
}
