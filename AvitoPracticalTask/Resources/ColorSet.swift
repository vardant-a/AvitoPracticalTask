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
            return UIColor.init(hexString: "#000000")
        } else {
            return UIColor.init(hexString: "#F2F2F7")
        }
    }

    static var tabBarItem = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor.systemOrange
        } else {
            return UIColor.systemBlue
        }
    }
    
    static var acceptColor = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
}
