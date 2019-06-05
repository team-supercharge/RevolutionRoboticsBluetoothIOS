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
    public func updateFirmware(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?) {
        guard let data = data(contentsOf: file, onError: onError) else { return }
        write(data: data, longMessageType: .firmwareData, onSuccess: onSuccess, onError: onError)
    }

    public func updateFramework(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?) {
        guard let data = data(contentsOf: file, onError: onError) else { return }
        write(data: data, longMessageType: .frameworkData, onSuccess: onSuccess, onError: onError)
    }

    public func testKit(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?) {
        guard let data = data(contentsOf: file, onError: onError) else { return }
        write(data: data, longMessageType: .testKit, onSuccess: onSuccess, onError: onError)
    }

    public func sendConfiguration(with file: URL, onSuccess: Callback?, onError: CallbackType<Error>?) {
        guard let data = data(contentsOf: file, onError: onError) else { return }
        write(data: data, longMessageType: .configurationData, onSuccess: onSuccess, onError: onError)
    }
}

// MARK: - Private methods
extension RoboticsConfigurationService {
    private func data(contentsOf url: URL, onError: ((Error) -> Void)?) -> Data? {
        do {
            let data = try Data.init(contentsOf: url)
            return data
        } catch {
            onError?(error)
            return nil
        }
    }

    private func write(data: Data,
                       longMessageType: LongMessageType,
                       onSuccess: Callback?,
                       onError: CallbackType<Error>?) {
        let longMessageData = LongMessageData(data: data, type: longMessageType)
        bluetoothController.write(data: longMessageData, onComplete: onSuccess, onError: onError)
    }
}
