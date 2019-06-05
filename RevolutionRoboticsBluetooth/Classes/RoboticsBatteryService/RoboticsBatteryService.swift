//
//  RoboticsBatteryService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsBatteryService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    public init() {
    }
}

// MARK: - RoboticsBatteryServiceInterface
extension RoboticsBatteryService: RoboticsBatteryServiceInterface {
    public func getPrimaryBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?) {
        getBatteryPercentage(for: RoboticsBatteryServiceCharacteristic.primaryBattery,
                             onComplete: onComplete,
                             onError: onError)
    }

    public func getMotorBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?) {
        getBatteryPercentage(for: RoboticsBatteryServiceCharacteristic.motorBattery,
                             onComplete: onComplete,
                             onError: onError)
    }
}

// MARK: - Private methods
extension RoboticsBatteryService {
    private func getBatteryPercentage(for characteristic: String,
                                      onComplete: CallbackType<Int>?,
                                      onError: CallbackType<Error>?) {
        bluetoothController.read(
            from: characteristic,
            serviceId: ServiceId.batteryService,
            onComplete: { data in
                guard let data = data else {
                    onError?(BluetoothControllerError.invalidServiceOrCharacteristic)
                    return
                }
                onComplete?(Int([UInt8](data)[0]))
        }, onError: { error in
            onError?(error)
        })
    }
}
