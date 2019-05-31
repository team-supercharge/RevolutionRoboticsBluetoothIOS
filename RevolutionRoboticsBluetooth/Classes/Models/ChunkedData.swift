//
//  ChunkedData.swift
//  CryptoSwift
//
//  Created by Gabor Nagy Farkas on 2019. 06. 05..
//

final class ChunkedData {
    var currentIndex: Int = 0
    var data: [[UInt8]]

    init(data: [[UInt8]]) {
        self.data = data
    }
}
