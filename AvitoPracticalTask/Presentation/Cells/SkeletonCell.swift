//
//  SkeletonCell.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

final class SkeletonCell: UICollectionViewCell {
    // MARK: - Public Properties

    static let cellID = "SkeletonCell"
    
    private let skeletonImageView = UIView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorSet.tabBarColor
        skeletonImageView.backgroundColor = .red
        contentView.addSubviewsDeactivateAutoMask(skeletonImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skeletonImageView.addGradientLayer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        layer.cornerRadius = Constants.cornerRadius
        skeletonImageView.layer.cornerRadius = Constants.cornerRadius
        skeletonImageView.addGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            skeletonImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            skeletonImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            skeletonImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            skeletonImageView.heightAnchor.constraint(
                equalToConstant: 200)
        ])
    }
}
