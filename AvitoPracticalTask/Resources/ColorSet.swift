//
//  ColorSet.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 28.08.2023.
//

import UIKit

enum ColorSet {
    static var tabBarColor = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor(hexString: "#1C1C1E")
        } else {
            return UIColor(hexString: "FFFFFF")
        }
    }

    static var backgroundColor = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor.black
        } else {
            return UIColor.white
        }
    }
}
