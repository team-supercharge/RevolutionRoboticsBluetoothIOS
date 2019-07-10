//
//  RoboticsConfigurationService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsConfigurationService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    public init() {
    }
}

// MARK: - RoboticsConfigurationServiceInterface
extension RoboticsConfigurationService: RoboticsConfigurationServiceInterface {
    public func updateFirmware(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?) {
        write(data: data, longMessageType: .firmwareData, onSuccess: onSuccess, onError: onError)
    }

    public func updateFramework(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?) {
        write(data: data, longMessageType: .frameworkData, onSuccess: onSuccess, onError: onError)
    }

    public func testKit(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?) {
        write(data: data, longMessageType: .testKit, onSuccess: onSuccess, onError: onError)
    }

    public func sendConfiguration(with data: Data, onSuccess: Callback?, onError: CallbackType<Error>?) {
        write(data: data, longMessageType: .configurationData, onSuccess: onSuccess, onError: onError)
    }
}

// MARK: - Private methods
extension RoboticsConfigurationService {
    private func write(data: Data,
                       longMessageType: LongMessageType,
                       onSuccess: Callback?,
                       onError: CallbackType<Error>?) {
        let longMessageData = LongMessageData(data: data, type: longMessageType)
        bluetoothController.write(data: longMessageData, onComplete: onSuccess, onError: onError)
    }
}
