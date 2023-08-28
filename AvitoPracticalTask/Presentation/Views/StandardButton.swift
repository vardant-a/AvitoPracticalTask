//
//  StandardButton.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

final class StandardButton: UIButton {
    
    // MARK: Init

    convenience init(
        _ target: Any?, title: String, titleColor: UIColor,
        buttonColor: UIColor, action: Selector) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = buttonColor
        addTarget(target, action: action, for: .touchUpInside)
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
