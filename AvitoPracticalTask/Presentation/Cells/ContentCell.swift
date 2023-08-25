//
//  ContentCell.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

struct TestModel {
    var id: Int?
    var title: String?
    var price: String?
}

final class ContentCell: UICollectionViewCell {
    // MARK: - Public Properties

    static let cellID = "ContentCollectionViewCell"

    // MARK: - Private Properties

    private var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        
        return imageView
    }()

    private var contentTitleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        contentView.addSubviewsDeactivateAutoMask(
            contentImageView, contentTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
        contentTitleLabel.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        layer.cornerRadius = 10
        contentImageView.layer.cornerRadius = layer.cornerRadius
    }

    // MARK: - Public Methods

    func configure(_ model: TestModel) {
        contentTitleLabel.text = model.title
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            contentImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            contentImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            contentImageView.heightAnchor.constraint(
                equalTo: contentImageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            contentTitleLabel.topAnchor.constraint(
                equalTo: contentImageView.bottomAnchor,
                constant: 4),
            contentTitleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8),
            contentTitleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -8)
        ])
    }
}
