//
//  BluetoothControllerInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

protocol BluetoothControllerInterface {
    func discover(discoveredDevices: StringArrayCallback?, onError: ErrorCallback?)
    func readData(from characteristiic: String,
                  on serviceId: String,
                  onComplete: StringCallback?,
                  onError: ErrorCallback?)
}
