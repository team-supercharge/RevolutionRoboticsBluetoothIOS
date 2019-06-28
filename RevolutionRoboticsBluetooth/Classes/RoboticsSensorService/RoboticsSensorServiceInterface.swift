//
//  RoboticsSensorServiceInterface.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public protocol RoboticsSensorServiceInterface {
    func read(id: Int, onSuccess: CallbackType<Data?>?, onError: CallbackType<Error>?)
}
