//
//  RoboticsSensorService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsSensorService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    // MARK: - Initialization
    public init() {
    }
}

// MARK: - RoboticsSensorServiceInterface
extension RoboticsSensorService: RoboticsSensorServiceInterface {
    public func read(id: Int, onSuccess: CallbackType<Data?>?, onError: CallbackType<Error>?) {
        bluetoothController.read(from: characteristic(for: id),
                                 serviceId: ServiceId.liveMessage,
                                 onComplete: onSuccess,
                                 onError: onError)
    }
}

// MARK: - Private methods
extension RoboticsSensorService {
    private func characteristic(for id: Int) -> String {
        switch id {
        case 1:
            return RoboticsSensorServiceCharacteristic.readSensor1
        case 2:
            return RoboticsSensorServiceCharacteristic.readSensor2
        case 3:
            return RoboticsSensorServiceCharacteristic.readSensor3
        case 4:
            return RoboticsSensorServiceCharacteristic.readSensor4
        default:
            return ""
        }
    }
}

