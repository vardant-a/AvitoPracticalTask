//
//  ColorSet.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 28.08.2023.
//

import UIKit

enum ColorSet {
    static var main = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor(hexString: "#1C1C1E")
        } else {
            return UIColor(hexString: "FFFFFF")
        }
    }

    static var background = UIColor { trait in
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
    
    static var accept = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }

    static var second = UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor.darkGray
        } else {
            return UIColor.lightGray
        }
    }
}
