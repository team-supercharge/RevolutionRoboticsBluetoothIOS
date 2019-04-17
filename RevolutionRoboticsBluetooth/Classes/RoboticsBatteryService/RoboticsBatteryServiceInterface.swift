//
//  RoboticsBatteryServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsBatteryServiceInterface {
    func getPrimaryBatteryPercentage(onComplete: IntCallback?, onError: ErrorCallback?)
    func getMotorBatteryPercentage(onComplete: IntCallback?, onError: ErrorCallback?)
}
