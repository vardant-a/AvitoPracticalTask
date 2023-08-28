//
//  StandardLabel.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

final class StandardLabel: UILabel {
    // MARK: - Init
    
    convenience init(_ type: LabelType) {
        self.init(frame: .zero)
        switch type {
        case .heightTitle:
            configure(
                font: UIFont.systemFont(ofSize: 33, weight: .black))
        case .lowTitle:
            configure(
                font: UIFont.systemFont(ofSize: 13))
        case .regular:
            configure()
        case .signature:
            configure(
                font: UIFont.systemFont(ofSize: 11, weight: .medium),
                andColor: .gray)
        case .secondText:
            configure(
                font: UIFont.systemFont(ofSize: 15, weight: .regular),
                andColor: .darkGray)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configure(font: UIFont? = UIFont.systemFont(ofSize: 17), andColor: UIColor? = .black) {
        self.font = font
        textColor = andColor
    }
}

    // MARK: - Style

extension StandardLabel {
    enum LabelType {
        case heightTitle, lowTitle, regular, signature, secondText
    }
}
