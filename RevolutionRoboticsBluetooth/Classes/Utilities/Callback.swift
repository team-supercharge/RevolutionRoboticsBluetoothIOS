//
//  Callback.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 17..
//

public typealias Callback = () -> Void
public typealias IntCallback = (Int) -> Void
public typealias StringCallback = (String) -> Void
public typealias StringArrayCallback = (String) -> Void
public typealias ErrorCallback = (Error) -> Void
public typealias DeviceArrayCallback = ([Device]) -> Void
public typealias MotorInfoCallback = (MotorInfo) -> Void
public typealias SensorInfoCallback = (SensorInfo) -> Void
