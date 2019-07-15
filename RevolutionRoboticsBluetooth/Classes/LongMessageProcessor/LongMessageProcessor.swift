//
//  LongMessageProcessor.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 06. 04..
//

import CoreBluetooth

final class LongMessageProcessor {
    // MARK: - Properties
    var isWriteInProgress = false
    private var messageQueue: [LongMessageQueueAction] = []
    private var onComplete: Callback?
    private var onError: CallbackType<Error>?
    private var connectedPeripheral: CBPeripheral?
    private var characteristic: CBCharacteristic?
}

// MARK: - Public methods
extension LongMessageProcessor {
    func start(connectedPeripheral: CBPeripheral,
               characteristic: CBCharacteristic,
               data: LongMessageData,
               onComplete: Callback?,
               onError: CallbackType<Error>?) {
        guard !isWriteInProgress else {
            onError?(LongMessageProcessorError.writeInProgress)
            teardown()
            return
        }
        self.isWriteInProgress = true
        self.onComplete = onComplete
        self.onError = onError
        self.connectedPeripheral = connectedPeripheral
        self.characteristic = characteristic
        prefillQueue(data: data)
        
        process(item: messageQueue.first)
    }

    func next(_ response: LongMessageReadResponse? = nil) {
        guard !messageQueue.isEmpty else {
            isWriteInProgress = false
            return
        }
        
        switch messageQueue.first! {
        case .uploadMessage(_, _):
            process(item: messageQueue.first, with: response)
        case .finalize:
            isWriteInProgress = false
            onComplete?()
            teardown()
        default:
            messageQueue.removeFirst()
            process(item: messageQueue.first, with: response)
        }
    }

    func stop() {
        messageQueue = [.finalize]
        process(item: messageQueue.first)
    }
}

// MARK: - Private methods
extension LongMessageProcessor {
    private func prefillQueue(data: LongMessageData) {
        switch data.type {
        case .firmwareData:
            messageQueue = [
                .select(.firmwareData),
                .readCheckSum,
                .initTransfer(.initTransfer, [UInt8](data.data).md5()),
                .uploadMessage(.upload, ChunkedData(data: [UInt8](data.data).chunked)),
                .finalize
            ]
        case .frameworkData:
            messageQueue = [
                .select(.frameworkData),
                .readCheckSum,
                .initTransfer(.initTransfer, [UInt8](data.data).md5()),
                .uploadMessage(.upload, ChunkedData(data: [UInt8](data.data).chunked)),
                .finalize
            ]
        case .configurationData:
            messageQueue = [
                .select(.configurationData),
                .readCheckSum,
                .initTransfer(.initTransfer, [UInt8](data.data).md5()),
                .uploadMessage(.upload, ChunkedData(data: [UInt8](data.data).chunked)),
                .finalize
            ]
        case .testKit:
            messageQueue = [
                .select(.testKit),
                .readCheckSum,
                .initTransfer(.initTransfer, [UInt8](data.data).md5()),
                .uploadMessage(.upload, ChunkedData(data: [UInt8](data.data).chunked)),
                .finalize
            ]
        }
    }

    private func process(item: LongMessageQueueAction?, with response: LongMessageReadResponse? = nil) {
        guard let action = item, let characteristic = characteristic else { return }
        switch action {
        case .select(let longMessageType):
            selectLongMessageType(longMessageType, on: characteristic)
        case .readCheckSum:
            connectedPeripheral?.readValue(for: characteristic)
        case .initTransfer(let type, let checksum):
            initTransfer(type, checksum: checksum, remoteChecksum: response?.checksum,on: characteristic)
        case .uploadMessage(let type, let data):
            uploadMessage(type, data: data, characteristic: characteristic)
        case .finalize:
            let data = Data([MessageType.finalize.rawValue])
            connectedPeripheral?.writeValue(data, for: characteristic, type: .withResponse)
        }
    }

    private func selectLongMessageType(_ type: LongMessageType, on characteristic: CBCharacteristic) {
        let array: [UInt8] = [0] + [type.rawValue]
        connectedPeripheral?.writeValue(Data(array), for: characteristic, type: .withResponse)
    }

    private func initTransfer(_ type: MessageType,
                              checksum: [UInt8],
                              remoteChecksum: [UInt8]?,
                              on characteristic: CBCharacteristic) {
        guard let remoteChecksum = remoteChecksum, !remoteChecksum.isEmpty, remoteChecksum == checksum else {
            let data = [type.rawValue] + checksum
            connectedPeripheral?.writeValue(Data(data), for: characteristic, type: .withResponse)
            return
        }

        messageQueue = [.finalize]
        process(item: messageQueue.first)
    }

    private func uploadMessage(_ type: MessageType, data: ChunkedData, characteristic: CBCharacteristic) {
        guard data.currentIndex < data.data.count else {
            messageQueue.removeFirst()
            process(item: messageQueue.first)
            return
        }

        let dataChunk = [type.rawValue] + data.data[data.currentIndex]
        connectedPeripheral?.writeValue(Data(dataChunk), for: characteristic, type: .withResponse)
        data.currentIndex += 1
    }

    private func teardown() {
        messageQueue = []
        onError = nil
        onComplete = nil
        connectedPeripheral = nil
        characteristic = nil
    }
}
