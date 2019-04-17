//
//  RoboticsLiveControllerServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsLiveControllerServiceInterface {
    func start()
    func stop()
    func updateXDirection(x: Int)
    func updateYDirection(y: Int)
    func changeButtonState(index: Int, pressed: Bool)
}
