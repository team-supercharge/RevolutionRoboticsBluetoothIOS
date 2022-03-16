//
//  LongMessageProcessorError.swift
//  CryptoSwift
//
//  Created by Gabor Nagy Farkas on 2019. 06. 05..
//

import Foundation

enum LongMessageProcessorError {
    static let writeInProgress = WriteInProgressError()
}

struct WriteInProgressError: LocalizedError {
    var errorDescription: String? = "RevolutionRoboticsBluetooth error: A long message write process is already in progress!"
    var failureReason: String? = "You tried to start another write process while one is in progress!"
    var recoverySuggestion: String?
    var helpAnchor: String?
}
