//
//  StandardLabel.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

final class StandardLabel: UILabel {
    
    enum Alignment {
        case top
        case bottom
    }
    
    var alignment: Alignment = .top
    
    // MARK: - Init
    
    convenience init(_ text: String? = nil, color: UIColor = ColorSet.accept,
                     fontOfSize: UIFont, numberOfLines: Int = 0) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.font = fontOfSize
        self.numberOfLines = numberOfLines
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        var rect = rect
        if alignment == .top {
            rect.size.height = sizeThatFits(rect.size).height
        } else if alignment == .bottom {
            let height = sizeThatFits(rect.size).height
            rect.origin.y += rect.size.height - height
            rect.size.height = height
        }
        super.drawText(in: rect)
    }
}
