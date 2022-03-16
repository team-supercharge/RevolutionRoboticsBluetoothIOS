//
//  BluetoothControllerInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation
import enum CoreBluetooth.CBManagerState

protocol BluetoothControllerInterface {
    var bluetoothRadioState: CBManagerState { get }

    func discover(discoveredDevices: CallbackType<[Device]>?, onError: CallbackType<Error>?)
    func stopDiscover()
    func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?)
    func disconnect()
    func read(from characteristic: String, serviceId: String, onComplete: CallbackType<Data?>?, onError: CallbackType<Error>?)
    func write(liveController: LiveControllerDataModel)
    func writeSystemId(data: Data, onComplete: Callback?, onError: CallbackType<Error>?)
    func write(data: LongMessageData, onComplete: Callback?, onError: CallbackType<Error>?)
    func stopWrite()
}
