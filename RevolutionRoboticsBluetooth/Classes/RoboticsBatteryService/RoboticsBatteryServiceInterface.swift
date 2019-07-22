//
//  RoboticsBatteryServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsBatteryServiceInterface {
    /// Retrieve the current primary battery charge percentage
    ///
    /// - Parameters:
    ///   - onComplete: Callback with the current percentage.
    ///   - onError: Error callback if the operation fails to complete.
    func getPrimaryBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?)

    /// Retrieve the current motor battery charge percentage
    ///
    /// - Parameters:
    ///   - onComplete: Callback with the current percentage.
    ///   - onError: Error callback if the operation fails to complete.
    func getMotorBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?)
}
