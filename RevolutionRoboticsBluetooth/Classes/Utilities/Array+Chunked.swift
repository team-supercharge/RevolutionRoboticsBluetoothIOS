//
//  Array+Chunked.swift
//  CryptoSwift
//
//  Created by Gabor Nagy Farkas on 2019. 06. 03..
//

import Foundation

extension Array where Element == UInt8 {
    private enum Constants {
        static let chunkSize = 511
    }

    var chunked: [[UInt8]] {
        guard chunkCount > 1 else { return [self] }

        var chunked: [[UInt8]] = []

        for offset in 0..<chunkCount {
            let startIndex: Int = offset * Constants.chunkSize
            let endIndex: Int = (offset + 1) * Constants.chunkSize
            var chunk: [UInt8] = []
            if endIndex >= self.count {
                chunk = Array(self[startIndex...])
            } else {
                chunk = Array(self[startIndex..<endIndex])
            }

            chunked.append(chunk)
        }

        return chunked
    }

    var chunkCount: Int {
        return Int(self.count / Constants.chunkSize) + (self.count % Constants.chunkSize != 1 ? 1 : 0)
    }
}
