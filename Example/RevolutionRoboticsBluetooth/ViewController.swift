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

    // MARK: - Properties
    private let discoverer = RoboticsDeviceDiscoverer()
    private let connector = RoboticsDeviceConnector()
    private let battery = RoboticsBatteryService()
    private let live = RoboticsLiveControllerService()
}

// MARK: - Actions
extension ViewController {
    @IBAction func connectButtonTap(_ sender: Any) {
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

    @IBAction func disconnectButtonTap(_ sender: Any) {
        connector.disconnect()
    }

    @IBAction func startButtonTap(_ sender: Any) {
        live.start()
    }

    @IBAction func stopButtonTap(_ sender: Any) {
        live.stop()
    }

    @IBAction func ySliderChanged(_ sender: UISlider) {
        live.updateYDirection(y: Int(sender.value))
    }

    @IBAction func xSliderChanged(_ sender: UISlider) {
        live.updateXDirection(x: Int(sender.value))
    }
    @IBAction func button1Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 0, pressed: sender.isSelected)
    }
    @IBAction func button2Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 1, pressed: sender.isSelected)
    }
    @IBAction func button3Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 2, pressed: sender.isSelected)
    }
    @IBAction func button4Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 3, pressed: sender.isSelected)
    }
    @IBAction func button5Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 4, pressed: sender.isSelected)
    }
    @IBAction func button6Tapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        live.changeButtonState(index: 5, pressed: sender.isSelected)
    }
}

