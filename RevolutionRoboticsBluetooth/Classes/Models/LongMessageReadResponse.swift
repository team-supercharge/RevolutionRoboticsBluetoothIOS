//
//  LongMessageReadResponse.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 06. 04..
//

import Foundation

struct LongMessageReadResponse {
    // MARK: - Constants
    private enum Constants {
        static let statusIndex = 0
        static let checksumRange = 1...16
        static let dataRange = 17...20
    }

    // MARK: - Properties
    let status: LongMessageReadStatus
    let checksum: [UInt8]
    let data: [UInt8]

    // MARK: - Initialization
    init?(data: Data?) {
        guard let data = data else { return nil }
        let dataArray = [UInt8](data)
        if data.count > 1 {
            self.status = LongMessageReadStatus(rawValue: dataArray[Constants.statusIndex])!
            self.checksum = Array(dataArray[Constants.checksumRange])
            self.data = Array(dataArray[Constants.dataRange])
        } else {
            self.status = LongMessageReadStatus(rawValue: dataArray[Constants.statusIndex])!
            self.checksum = []
            self.data = []
        }
    }
}
