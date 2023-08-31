//
//  UIView+EX.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

extension UIView {
    func addSubviewsDeactivateAutoMask(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func removeSubviews() {
        subviews.forEach {
            $0.removeSubviews()
        }
    }

    func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius == 0
        ? self.layer.cornerRadius
        : 10
        
        let startColor = UIColor.lightGray.cgColor
        let endColor = UIColor.darkGray.cgColor
        gradientLayer.colors = [startColor, endColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)

        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.fromValue = [startColor, endColor]
        gradientAnimation.toValue = [endColor, startColor]
        gradientAnimation.duration = 0.7 // Длительность анимации (в секундах)
        gradientAnimation.autoreverses = true // Повтор анимации в обратном порядке
        gradientAnimation.repeatCount = Float.infinity // Бесконечное повторение анимации
        gradientLayer.add(gradientAnimation, forKey: "gradientAnimation")
        layer.addSublayer(gradientLayer)
    }
}
