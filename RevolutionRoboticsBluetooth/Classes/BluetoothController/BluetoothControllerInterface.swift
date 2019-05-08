//
//  BluetoothControllerInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

protocol BluetoothControllerInterface {
    func discover(discoveredDevices: CallbackType<[Device]>?, onError: CallbackType<Error>?)
    func stopDiscover()
    func connect(to device: Device, onConnected: Callback?, onDisconnected: Callback?, onError: CallbackType<Error>?)
    func disconnect()
    func read(from characteristic: String, serviceId: String, onComplete: CallbackType<Data?>?, onError: CallbackType<Error>?)
    func write(liveController: LiveControllerDataModel)
}
