//
//  LiveControllerDataModel.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 24..
//

final class LiveControllerDataModel: CustomStringConvertible {
    // MARK: - Properties
    var xDirection: Int
    var yDirection: Int
    var buttonStates: [Bool]

    var description: String {
        return "LiveControllerDataModel - x: \(xDirection), y: \(yDirection), buttonStates: \(buttonStates)"
    }

    // MARK: - Initializers
    init(xDirection: Int, yDirection: Int, buttonStates: [Bool]) {
        self.xDirection = xDirection
        self.yDirection = yDirection
        self.buttonStates = buttonStates
    }
}
