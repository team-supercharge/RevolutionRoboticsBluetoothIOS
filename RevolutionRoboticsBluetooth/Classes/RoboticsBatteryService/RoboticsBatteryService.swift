//
//  RoboticsBatteryService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsBatteryService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController()
}

// MARK: - RoboticsBatteryServiceInterface
extension RoboticsBatteryService: RoboticsBatteryServiceInterface {
    public func getPrimaryBatteryPercentage(onComplete: IntCallback?, onError: ErrorCallback?) {
    }

    public func getMotorBatteryPercentage(onComplete: IntCallback?, onError: ErrorCallback?) {
    }
}
