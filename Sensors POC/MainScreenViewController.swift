//
//  MainScreenViewController.swift
//  Sensors POC
//
//  Created by Sergio Miguel on 8/10/20.
//  Copyright © 2020 Kaputt. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    lazy var bgLayer = CAGradientLayer()

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
