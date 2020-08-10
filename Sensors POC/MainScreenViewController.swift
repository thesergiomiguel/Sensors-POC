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
    let motionManager = CMMotionManager()
    var timer: Timer?

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
        startAccelerometerUpdates()
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
}

extension MainScreenViewController {
    func startAccelerometerUpdates() {
//        let interval = 1 / 60.0
        let interval = 1 / 2.0

        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates()

        timer = Timer(fire: Date(), interval: interval, repeats: true) { timer in
            if let data = self.motionManager.accelerometerData {
                print(data)
            }
        }

        RunLoop.current.add(self.timer!, forMode: .default)
    }
}
