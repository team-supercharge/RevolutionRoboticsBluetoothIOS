//
//  BluetoothControllerError.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 24..
//

import Foundation

enum BluetoothControllerError {
    static let bluetoothIsNotPoweredOn = BluetoothIsNotPoweredOnError()
    static let invalidServiceOrCharacteristic = InvalidServiceOrCharacteristic()
    static let invalidCharacterEncoding = InvalidCharacterEncoding()
}

struct BluetoothIsNotPoweredOnError: LocalizedError {
    var errorDescription: String? = "RevolutionRoboticsBluetooth error: Bluetooth is not powered on!"
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}

struct InvalidServiceOrCharacteristic: LocalizedError {
    var errorDescription: String? = "RevolutionRoboticsBluetooth error: You requested an invalid service or characteristic!"
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}

struct InvalidCharacterEncoding: LocalizedError {
    var errorDescription: String? = "RevolutionRoboticsBluetooth error: You received data with wrong encoding!"
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}
