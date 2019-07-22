//
//  RoboticsConfigurationServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsConfigurationServiceInterface {
    /// Send firmware data to the robot.
    ///
    /// - Parameters:
    ///   - data: Downloaded firmware data.
    ///   - onSuccess: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func updateFirmware(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)

    /// Send framework data to the robot.
    ///
    /// - Parameters:
    ///   - data: Downloaded framework data.
    ///   - onSuccess: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func updateFramework(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)

    /// Send a test code to the robot.
    ///
    /// - Parameters:
    ///   - data: The encoded JSON.
    ///   - onSuccess: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func testKit(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)

    /// Send the configuration to the robot.
    ///
    /// - Parameters:
    ///   - data: The encoded JSON.
    ///   - onSuccess: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func sendConfiguration(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?)

    /// Stop any writing operation to device.
    func stopWrite()
}
