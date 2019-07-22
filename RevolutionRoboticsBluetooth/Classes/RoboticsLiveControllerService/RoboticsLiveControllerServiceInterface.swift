//
//  RoboticsLiveControllerServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsLiveControllerServiceInterface {
    /// Start keepalive.
    func start()

    /// Stop keepalive.
    func stop()

    /// Update the X direction of the robot
    ///
    /// - Parameters:
    ///   - x: X direction (Int between 0-255)
    func updateXDirection(x: Int)

    /// Update the Y direction of the robot
    ///
    /// - Parameters:
    ///   - y: Y direction (Int between 0-255)
    func updateYDirection(y: Int)

    /// Change the state of the button on a controller.
    ///
    /// - Parameters:
    ///   - index: Index of the button.
    ///   - pressed: State of the button.
    func changeButtonState(index: Int, pressed: Bool)
}
