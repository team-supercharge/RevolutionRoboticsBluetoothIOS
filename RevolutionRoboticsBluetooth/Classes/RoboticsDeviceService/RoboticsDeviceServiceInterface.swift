//
//  RoboticsDeviceServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsDeviceServiceInterface {
    /// Get the serial number of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getSerialNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)

    /// Set the system ID of the connected device.
    ///
    /// - Parameters:
    ///   - id: New device ID
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func setSystemId(id: String, onCompleted: Callback?, onError: CallbackType<Error>?)
    
    /// Get the manufacturer's name of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getManufacturerName(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)

    /// Get the hardware revision of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getHardwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)

    /// Get the software revision of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getSoftwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)

    /// Get the firmware version of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getFirmwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)

    /// Get the system ID of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getSystemId(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)

    /// Get the model number of the connected device.
    ///
    /// - Parameters:
    ///   - onCompleted: Callback when the operation is successful.
    ///   - onError: Error callback if the operation fails to complete.
    func getModelNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?)
}
