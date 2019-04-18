//
//  RoboticsMotorServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsMotorServiceInterface {
    func read(id: Int, onSuccess: CallbackType<MotorInfo>?, onError: CallbackType<Error>?)
}
