//
//  RoboticsLiveControllerService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsLiveControllerService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController()
}

// MARK: - RoboticsLiveControllerServiceInterface
extension RoboticsLiveControllerService: RoboticsLiveControllerServiceInterface {
}
