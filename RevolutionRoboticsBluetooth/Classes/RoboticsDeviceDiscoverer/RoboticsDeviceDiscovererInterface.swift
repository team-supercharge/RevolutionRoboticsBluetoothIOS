//
//  RoboticsDeviceDiscovererInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import enum CoreBluetooth.CBManagerState

public protocol RoboticsDeviceDiscovererInterface {
    /// Current bluetooth radio state.
    var bluetoothRadioState: CBManagerState { get }

    /// Start discovery of bluetooth devices nearby.
    ///
    /// - Parameters:
    ///   - onScanResult: Callback when the scan receives new devices.
    ///   - onError: Error callback if the operation fails to complete.
    func discoverRobots(onScanResult: CallbackType<[Device]>?, onError: CallbackType<Error>?)

    /// Stop the discovery.
    func stopDiscover()
}
