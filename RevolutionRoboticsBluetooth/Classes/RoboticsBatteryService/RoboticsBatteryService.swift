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
        bluetoothController.read(
            from: RoboticsBatteryServiceCharacteristic.primaryBattery,
            serviceId: ServiceId.batteryService,
            onComplete: { data in
                guard let data = data else {
                    onError?(BluetoothControllerError.invalidServiceOrCharacteristic)
                    return
                }
                print(String(describing: data))
        }, onError: { error in
            print(error.localizedDescription)
        })
    }

    public func getMotorBatteryPercentage(onComplete: CallbackType<Int>?, onError: CallbackType<Error>?) {
    }
}
