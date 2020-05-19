//
//  RoboticsDeviceService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsDeviceService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared

    public init() {
    }
}

// MARK: - RoboticsDeviceServiceInterface
extension RoboticsDeviceService: RoboticsDeviceServiceInterface {
    public func setSystemId(id: String, onCompleted: Callback?, onError: CallbackType<Error>?) {
        writeString(id, onComplete: onCompleted, onError: onError)
    }
    
    public func getSerialNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.serialNumber,
                   onComplete: onCompleted,
                   onError: onError)
    }

    public func getManufacturerName(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.manufacturerName,
                   onComplete: onCompleted,
                   onError: onError)
    }

    public func getHardwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.hardwareRevision,
                   onComplete: onCompleted,
                   onError: onError)
    }

    public func getSoftwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.softwareRevision,
                   onComplete: onCompleted,
                   onError: onError)
    }

    public func getFirmwareRevision(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.firmwareRevision,
                   onComplete: onCompleted,
                   onError: onError)
    }

    public func getSystemId(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.systemId,
                   onComplete: onCompleted,
                   onError: onError)
    }

    public func getModelNumber(onCompleted: CallbackType<String>?, onError: CallbackType<Error>?) {
        readString(from: RoboticsDeviceServiceCharacteristic.modelNumber,
                   onComplete: onCompleted,
                   onError: onError)
    }
}

// MARK: - Private methods
extension RoboticsDeviceService {
    private func writeString(_ id: String,
                            onComplete: Callback?,
                            onError: CallbackType<Error>?) {
        guard
            let encoded = id.data(using: .utf8)?.base64EncodedString(),
            let encodedData = Data(base64Encoded: encoded)
        else { return }

        bluetoothController.writeSystemId(data: encodedData, onComplete: onComplete, onError: onError)
    }

    private func readString(from characteristic: String,
                            onComplete: CallbackType<String>?,
                            onError: CallbackType<Error>?) {
        bluetoothController.read(
            from: characteristic,
            serviceId: ServiceId.deviceInformationService,
            onComplete: { data in
                guard let data = data else {
                    onError?(BluetoothControllerError.invalidServiceOrCharacteristic)
                    return
                }
                guard let string = String(bytes: data, encoding: .utf8) else {
                    onError?(BluetoothControllerError.invalidCharacterEncoding)
                    return
                }

                onComplete?(string)
        }, onError: { error in
            onError?(error)
        })
    }
}
