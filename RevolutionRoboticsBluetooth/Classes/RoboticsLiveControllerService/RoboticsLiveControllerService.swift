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
    public func start() {
    }

    public func stop() {
    }

    public func updateXDirection(x: Int) {
    }

    public func updateYDirection(y: Int) {
    }

    public func changeButtonState(index: Int, pressed: Bool) {
    }
}
