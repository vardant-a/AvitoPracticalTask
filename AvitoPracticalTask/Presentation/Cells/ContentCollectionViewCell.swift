//
//  ContentCollectionViewCell.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

final class ContentCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties

    static let cellID = "ContentCollectionViewCell"

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
