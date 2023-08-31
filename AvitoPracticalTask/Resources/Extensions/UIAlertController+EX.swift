//
//  UIAlertController+EX.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 31.08.2023.
//

import UIKit

extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach {
            addAction($0)
        }
    }
}
