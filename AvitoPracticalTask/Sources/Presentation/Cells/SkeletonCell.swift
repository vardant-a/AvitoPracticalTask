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
    
    private let emptyView = UIView()
    private let titleView = UIView()
    private let secondTitleView = UIView()
    private let addressView = UIView()
    private let dateView = UIView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubviewsDeactivateAutoMask(
            emptyView, titleView, secondTitleView,
            addressView, dateView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        layer.cornerRadius = Constants.cornerRadius
        configureSkelet(emptyView)
        configureSkelet(titleView)
        configureSkelet(secondTitleView)
        configureSkelet(addressView)
        configureSkelet(dateView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emptyView.addGradientLayer()
    }

    // MARK: - Private Methods
    
    private func configureSkelet(_ view: UIView) {
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.addGradientLayer()
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            emptyView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            emptyView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            emptyView.heightAnchor.constraint(
                equalTo: emptyView.widthAnchor)
        ])
    
        setupViewLayout(titleView, toView: emptyView, offset: 8, trailingOffset: 32)
        setupViewLayout(secondTitleView, toView: titleView, offset: 4)
        setupViewLayout(addressView, toView: secondTitleView, offset: 4)
        setupViewLayout(dateView, toView: addressView, offset: 4, trailingOffset: 64)
    }
    
    private func setupViewLayout(_ view: UIView, toView: UIView, offset: CGFloat, trailingOffset: CGFloat = 0) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(
                equalTo: toView.bottomAnchor, constant: offset),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -trailingOffset),
            view.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}
