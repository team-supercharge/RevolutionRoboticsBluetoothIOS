//
//  RoboticsLiveControllerService.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

import Foundation

public final class RoboticsLiveControllerService {
    // MARK: - Properties
    private let bluetoothController: BluetoothControllerInterface = BluetoothController.shared
    private var timer: Timer?
    private var dataModel = LiveControllerDataModel(xDirection: 127,
                                                    yDirection: 127,
                                                    buttonStates: [false, false, false, false, false, false])

    public init() {
    }
}

// MARK: - RoboticsLiveControllerServiceInterface
extension RoboticsLiveControllerService: RoboticsLiveControllerServiceInterface {
    public func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(fireKeepAlive),
                                     userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }

    public func updateXDirection(x: Int) {
        dataModel.xDirection = x
    }

    public func updateYDirection(y: Int) {
        dataModel.yDirection = y
    }

    public func changeButtonState(index: Int, pressed: Bool) {
        dataModel.buttonStates[index] = pressed
    }
}

// MARK: - Timer
extension RoboticsLiveControllerService {
    @objc func fireKeepAlive() {
        bluetoothController.write(liveController: dataModel)
        resetButtonStates()
    }

    private func resetButtonStates() {
        dataModel.buttonStates = [false, false, false, false, false, false]
    }
}
