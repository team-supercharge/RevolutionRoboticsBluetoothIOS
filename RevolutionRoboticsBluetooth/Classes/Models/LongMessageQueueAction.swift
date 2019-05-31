//
//  LongMessageQueueAction.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 06. 04..
//

enum LongMessageQueueAction {
    case select(LongMessageType)
    case readCheckSum
    case initTransfer(MessageType, [UInt8])
    case uploadMessage(MessageType, ChunkedData)
    case finalize
}
