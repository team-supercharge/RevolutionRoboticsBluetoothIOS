//
//  RoboticsSensorServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public protocol RoboticsSensorServiceInterface {
    /// Read data from the given sensor.
    ///
    /// - Parameters:
    ///   - id: ID of the sensor.
    ///   - onSuccess: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func read(id: Int, onSuccess: CallbackType<Data?>?, onError: CallbackType<Error>?)
}
