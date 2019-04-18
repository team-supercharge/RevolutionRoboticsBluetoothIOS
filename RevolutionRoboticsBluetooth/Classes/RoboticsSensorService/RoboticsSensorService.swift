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
}

// MARK: - RoboticsSensorServiceInterface
extension RoboticsSensorService: RoboticsSensorServiceInterface {
    public func read(id: Int, onSuccess: CallbackType<SensorInfo>?, onError: CallbackType<Error>?) {
    }
}
