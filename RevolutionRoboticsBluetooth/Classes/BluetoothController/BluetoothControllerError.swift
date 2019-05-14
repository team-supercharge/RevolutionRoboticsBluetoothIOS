//
//  BluetoothControllerError.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 24..
//

enum BluetoothControllerError: Error {
    case bluetoothIsNotPoweredOn
    case invalidServiceOrCharacteristic
    case invalidCharacterEncoding

    var localizedDescription: String {
        switch self {
        case .bluetoothIsNotPoweredOn:
            return "❌ Bluetooth is not powered on!"
        case .invalidServiceOrCharacteristic:
            return "❌ You requested an invalide service or characteristic!"
        case .invalidCharacterEncoding:
            return "❌ You received data with wrong encoding!"
        }
    }
}
