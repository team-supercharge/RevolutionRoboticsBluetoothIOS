//
//  Characteristics.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 2019. 04. 15..
//

import Foundation

enum GeneralCharacteristic: String {
    case battery1 = "00002a19-0000-1000-8000-00805f9b34fb"
    case battery2 = "00002a19-0000-1000-8000-00805f9b34fa"
    case firmwareVersion = "00002a26-0000-1000-8000-00805f9b34fb"
    case serialNumber = "00002a00-0000-1000-8000-00805f9b34fb"
}

enum LongMessageCharacteristic: String {
    case brainToMobile = "d59bb321-7218-4fb9-abac-2f6814f31a4d"
    case mobileToBrain = "b81239d9-260b-4945-bcfe-8b1ef1fc2879"
}

enum LongMessageFunctionCharacteristic: String {
    case updateFirmware = "97148a04-5b9d-11e9-8647-d663bd873d93"
    case updateFramework = "97148e28-5b9d-11e9-8647-d663bd873d93"
    case testKit = "97148f90-5b9d-11e9-8647-d663bd873d93"
    case sendConfiguration = "971490c6-5b9d-11e9-8647-d663bd873d93"
    case sendProgram = "971492d8-5b9d-11e9-8647-d663bd873d93"
    case changeName = "971495d0-5b9d-11e9-8647-d663bd873d93"
}

enum LiveMessageFunctionCharacteristic: String {
    case readMotor1 = "4bdfb409-93cc-433a-83bd-7f4f8e7eaf54"
    case readMotor2 = "454885b9-c9d1-4988-9893-a0437d5e6e9f"
    case readMotor3 = "00fcd93b-0c3c-4940-aac1-b4c21fac3420"
    case readMotor4 = "49aaeaa4-bb74-4f84-aa8f-acf46e5cf922"
    case readMotor5 = "ceea8e45-5ff9-4325-be13-48cf40c0e0c3"
    case readMotor6 = "8e4c474f-188e-4d2a-910a-cf66f674f569"
    case readSensor1 = "135032e6-3e86-404f-b0a9-953fd46dcb17"
    case readSensor2 = "36e944ef-34fe-4de2-9310-394d482e20e6"
    case readSensor3 = "b3a71566-9af2-4c9d-bc4a-6f754ab6fcf0"
    case readSensor4 = "9ace575c-0b70-4ed5-96f1-979a8eadbc6b"
    case startStoredProgram = "7486bec3-bb6b-4abd-a9ca-20adc281a0a4"
    case updateDirection = "1e01230f-f5f3-4a94-aac8-d09cd48f8d79"
    case keepAlive = "9e55ea41-69c3-4729-9f9a-90bc27ab6253"
}
