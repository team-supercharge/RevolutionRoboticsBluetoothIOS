//
//  RoboticsBatteryServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsBatteryServiceInterface {
    func getPrimaryBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?)
    func getMotorBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?)
}
