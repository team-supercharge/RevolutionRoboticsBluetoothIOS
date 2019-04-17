//
//  RoboticsConfigurationService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsConfigurationService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController()
}

// MARK: - RoboticsConfigurationServiceInterface
extension RoboticsConfigurationService: RoboticsConfigurationServiceInterface {
    public func updateFirmware(with file: URL, onSuccess: Callback?, onError: ErrorCallback?) {
    }

    public func updateFramework(with file: URL, onSuccess: Callback?, onError: ErrorCallback?) {
    }

    public func testKit(with file: URL, onSuccess: Callback?, onError: ErrorCallback?) {
    }

    public func sendConfiguration(with file: URL, onSuccess: Callback?, onError: ErrorCallback?) {
    }

    public func changeName(with name: String, onSuccess: Callback?, onError: ErrorCallback?) {
    }
}
