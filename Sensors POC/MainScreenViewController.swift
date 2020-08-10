//
//  MainScreenViewController.swift
//  Sensors POC
//
//  Created by Sergio Miguel on 8/10/20.
//  Copyright © 2020 Kaputt. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Setup
    func setup() {
        setupBackground()
    }
}

// MARK: - Background view
extension MainScreenViewController {
    class GradientBackground: UIView {
        override class var layerClass: AnyClass {
            return CAGradientLayer.self
        }
    }

    func setupBackground() {
        let backgroundView = GradientBackground(frame: view.bounds)

        if let layer = backgroundView.layer as? CAGradientLayer {
            layer.colors = [
                UIColor(red: 0.45, green: 0.75, blue: 0.35, alpha: 1).cgColor,
                UIColor(red: 0.15, green: 0.75, blue: 0.35, alpha: 1).cgColor,
                UIColor(red: 0.10, green: 0.80, blue: 0.35, alpha: 1).cgColor,
            ]
        }

        view.addSubview(backgroundView)
    }
}
