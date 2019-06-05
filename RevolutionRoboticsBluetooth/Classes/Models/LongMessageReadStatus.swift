//
//  LongMessageReadStatus.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 06. 04..
//

enum LongMessageReadStatus: UInt8 {
    case unused = 0
    case upload = 1
    case validation = 2
    case ready = 3
    case validationError = 4
}
