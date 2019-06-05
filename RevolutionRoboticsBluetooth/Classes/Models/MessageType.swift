//
//  MessageType.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 06. 04..
//

enum MessageType: UInt8 {
    case select = 0
    case initTransfer = 1
    case upload = 2
    case finalize = 3
}
