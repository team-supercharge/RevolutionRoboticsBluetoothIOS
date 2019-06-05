//
//  ViewController.swift
//  RevolutionRoboticsBluetooth
//
//  Created by Gabor Nagy Farkas on 04/16/2019.
//  Copyright (c) 2019 Gabor Nagy Farkas. All rights reserved.
//

import UIKit
import RevolutionRoboticsBluetooth

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var connectButton: UIButton!
    @IBOutlet private weak var disconnectButton: UIButton!
    @IBOutlet private weak var startKeepaliveButton: UIButton!
    @IBOutlet private weak var stopKeepaliveButton: UIButton!
    @IBOutlet private weak var xDirectionSlider: UISlider!
    @IBOutlet private weak var yDirectionSlider: UISlider!
    @IBOutlet private weak var button1: UIButton!
    @IBOutlet private weak var button2: UIButton!
    @IBOutlet private weak var button3: UIButton!
    @IBOutlet private weak var button4: UIButton!
    @IBOutlet private weak var button5: UIButton!
    @IBOutlet private weak var button6: UIButton!
    @IBOutlet private weak var readBatteryButton: UIButton!
    @IBOutlet private weak var readSystemInfoButton: UIButton!
    @IBOutlet private weak var sendTestFileButton: UIButton!

    // MARK: - Properties
    private let discoverer = RoboticsDeviceDiscoverer()
    private let connector = RoboticsDeviceConnector()
    private let battery = RoboticsBatteryService()
    private let live = RoboticsLiveControllerService()
    private let deviceService = RoboticsDeviceService()
    private let configurationService = RoboticsConfigurationService()
}

// MARK: - Actions
extension ViewController {
    @IBAction private func connectButtonTap(_ sender: Any) {
        print("📱 Discovery started!")
        discoverer.discoverRobots(
            onScanResult: { [weak self] devices in
                print("📱 Scan completed with \(devices.count) result!")
                self?.discoverer.stopDiscover()
                print("📱 Discovery stopped!")
                self?.connector.connect(
                    to: devices.first!,
                    onConnected: {
                        print("📱 Device connected!")
                },
                    onDisconnected: {
                        print("📱 ❌ Device disconnected!")
                },
                    onError: { error in
                        print("📱 ❌ Connection failed! - \(error.localizedDescription)")
                })
            }, onError: { error in
                print("📱 ❌ Discovery failed! - \(error.localizedDescription)")
        })
    }

    @IBAction private func disconnectButtonTap(_ sender: Any) {
        connector.disconnect()
    }

    @IBAction private func startButtonTap(_ sender: Any) {
        live.start()
    }

    @IBAction private func stopButtonTap(_ sender: Any) {
        live.stop()
    }

    @IBAction private func ySliderChanged(_ sender: UISlider) {
        live.updateYDirection(y: Int(sender.value))
    }

    @IBAction private func xSliderChanged(_ sender: UISlider) {
        live.updateXDirection(x: Int(sender.value))
    }

    @IBAction private func button1Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 0, pressed: sender.isSelected)
    }

    @IBAction private func button2Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 1, pressed: sender.isSelected)
    }

    @IBAction private func button3Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 2, pressed: sender.isSelected)
    }

    @IBAction private func button4Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 3, pressed: sender.isSelected)
    }

    @IBAction private func button5Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 4, pressed: sender.isSelected)
    }

    @IBAction private func button6Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 5, pressed: sender.isSelected)
    }

    @IBAction private func readBatteryButtonTapped(_ sender: UIButton) {
        battery.getMotorBatteryPercentage(onComplete: { percentage in
            print("📱 Motor battery percentage: \(percentage) %")
        }, onError: { error in
            print("📱 ❌ Motor battery percentage read failed! - \(error.localizedDescription)")
        })

        battery.getPrimaryBatteryPercentage(onComplete: { percentage in
            print("📱 Primary battery percentage: \(percentage) %")
        }, onError: { error in
            print("📱 ❌ Primary battery percentage read failed! - \(error.localizedDescription)")
        })
    }

    @IBAction private func readSystemInfoButtonTapped(_ sender: UIButton) {
        deviceService.getSerialNumber(onCompleted: { serialNumber in
            print("📱 Robot serial number: \(serialNumber)")
        }, onError: { error in
            print("📱 ❌ Serial number read failed: \(error.localizedDescription)")
        })

        deviceService.getManufacturerName(onCompleted: { manufacturerName in
            print("📱 Robot manufacturer name: \(manufacturerName)")
        }, onError: { error in
            print("📱 ❌ Manufacturer name read failed: \(error.localizedDescription)")
        })

        deviceService.getHardwareRevision(onCompleted: { hardwareRevision in
            print("📱 Robot hardware revision: \(hardwareRevision)")
        }, onError: { error in
            print("📱 ❌ Hardware revision read failed: \(error.localizedDescription)")
        })

        deviceService.getSoftwareRevision(onCompleted: { softwareRevision in
            print("📱 Robot software revision: \(softwareRevision)")
        }, onError: { error in
            print("📱 ❌ Software revision read failed: \(error.localizedDescription)")
        })

        deviceService.getFirmwareRevision(onCompleted: { firwareRevision in
            print("📱 Robot firmware revision: \(firwareRevision)")
        }, onError: { error in
            print("📱 ❌ Firmware revision read failed: \(error.localizedDescription)")
        })

        deviceService.getSystemId(onCompleted: { systemId in
            print("📱 Robot system id: \(systemId)")
        }, onError: { error in
            print("📱 ❌ System id read failed: \(error.localizedDescription)")
        })

        deviceService.getModelNumber(onCompleted: { modelNumber in
            print("📱 Robot model number: \(modelNumber)")
        }, onError: { error in
            print("📱 ❌ Model number read failed: \(error.localizedDescription)")
        })
    }

    @IBAction func sendTestFileTapped(_ sender: Any) {
        let url = Bundle.main.url(forResource: "led_test", withExtension: ".py")!
        configurationService.testKit(
            with: url,
            onSuccess: {
                print("📱 Successfully processed the program!")
        },
            onError: { error in
                print(error.localizedDescription)
        })
    }
}

