//
//  StandardLabel.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

enum FontSet {
    static let cellH1 = UIFont.systemFont(ofSize: 16)
    static let cellH1Bold = UIFont.systemFont(ofSize: 15, weight: .black)
    static let textH1 = UIFont.systemFont(ofSize: 24)
    static let textH2 = UIFont.systemFont(ofSize: 20, weight: .black)
    static let textH3 = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let textH4 = UIFont.systemFont(ofSize: 17)
    static let targetText = UIFont.systemFont(ofSize: 25, weight: .black)
}

final class StandardLabel: UILabel {
    
    enum Alignment {
        case top
        case bottom
    }
    
    var alignment: Alignment = .top
    
    // MARK: - Init
    
    convenience init(_ text: String? = nil, color: UIColor = ColorSet.acceptColor,
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
