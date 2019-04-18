//
//  BluetoothControllerError.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 24..
//

enum BluetoothControllerError: Error {
    case bluetoothIsNotPoweredOn
    case invalidServiceOrCharacteristic

    var localizedDescription: String {
        switch self {
        case .bluetoothIsNotPoweredOn:
            return "❌ Bluetooth is not powered on!"
        case .invalidServiceOrCharacteristic:
            return "❌ You requested an invalide service or characteristic!"
        }
    }
}
