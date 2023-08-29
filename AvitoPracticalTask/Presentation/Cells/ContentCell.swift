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
        imageView.clipsToBounds = true
        
        return imageView
    }()

    private var contentTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2

        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorSet.tabBarColor
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
        layer.cornerRadius = Constants.cornerRadius
        contentImageView.layer.cornerRadius = Constants.cornerRadius
    }

    // MARK: - Public Methods

    func configure(_ model: Advertisement) {
        contentTitleLabel.text = model.title
        Task {
            guard let imageUrl = model.imageUrl else { return }
            let result = await NetworkManager().fetchImage(imageUrl)
            switch result {
            case .success(let success):
                contentImageView.image = UIImage(data: success)
            case .failure(_):
                print("1")
            }
        }
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
