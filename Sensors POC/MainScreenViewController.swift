//
//  MainScreenViewController.swift
//  Sensors POC
//
//  Created by Sergio Miguel on 8/10/20.
//  Copyright © 2020 Kaputt. All rights reserved.
//

import UIKit
import CoreMotion

class MainScreenViewController: UIViewController {
    lazy var bgLayer = CAGradientLayer()
    lazy var button = UIButton()
    lazy var recordImage = UIImage(systemName: "circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
    lazy var stopImage = UIImage(systemName: "stop.fill")

    let motionManager = CMMotionManager()

    var timer: Timer?
    var referenceAttitude: CMAttitude?
    var isRecording = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidLayoutSubviews() {
        bgLayer.frame = view.bounds
    }

    // MARK: - Setup
    func setup() {
        setupBackground()
        setupButton()
    }

    // MARK: - Background layer
    func setupBackground() {
        bgLayer.colors = [
            UIColor(red: 0.45, green: 0.75, blue: 0.35, alpha: 1).cgColor,
            UIColor(red: 0.15, green: 0.75, blue: 0.35, alpha: 1).cgColor,
            UIColor(red: 0.10, green: 0.80, blue: 0.35, alpha: 1).cgColor,
        ]

        view.layer.insertSublayer(bgLayer, at: 0)
    }

    func setupButton() {
        button.setImage(recordImage, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc func buttonPressed() {
        isRecording.toggle()

        if isRecording {
            startTracking()
            button.setImage(stopImage, for: .normal)

            return
        }

        stopTracking()
        button.setImage(recordImage, for: .normal)
    }
}

// MARK: - Accelerometer control
extension MainScreenViewController {
    func startTracking() {

//        let interval = 1 / 60.0
        let interval = 1 / 2.0

        motionManager.deviceMotionUpdateInterval = interval
        motionManager.showsDeviceMovementDisplay = true
        motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical)

        timer = Timer(fire: Date(), interval: interval, repeats: true) { timer in
            if let data = self.motionManager.deviceMotion {
                if self.referenceAttitude == nil {
                    self.referenceAttitude = data.attitude

                    print("Reference attitude has been set to \(String(describing: self.referenceAttitude))")

                    return
                }

                data.attitude.multiply(byInverseOf: self.referenceAttitude!)

//                let x = self.degrees(data.attitude.pitch)
                let y = self.degrees(data.attitude.roll)
                let z = self.degrees(data.attitude.yaw)

//                print("pitch is \(attitude.pitch), roll is \(attitude.roll), and yaw is \(attitude.yaw)")
//                print("x: \(x); y: \(y); z: \(z)")
                print("y: \(y); z: \(z)")
            }
        }

        RunLoop.current.add(self.timer!, forMode: .default)
    }

    func stopTracking() {
        motionManager.stopDeviceMotionUpdates()

        referenceAttitude = nil

        timer?.invalidate()
        timer = nil
    }

    func degrees(_ radians: Double) -> Double {
        return 180 / Double.pi * radians;
    }
}
