//
//  ContentCell.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

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

    private var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "more"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubviewsDeactivateAutoMask(
            contentImageView, contentTitleLabel, moreButton)
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

    func configure(_ target: Any?, model: Advertisement, action: Selector) {
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
    
        moreButton.addTarget(target, action: action, for: .touchUpInside)
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
                equalTo: contentImageView.widthAnchor),
            
            moreButton.topAnchor.constraint(
                equalTo: contentImageView.bottomAnchor,
                constant: 4),
            moreButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 20),
            
            contentTitleLabel.topAnchor.constraint(
                equalTo: contentImageView.bottomAnchor,
                constant: 4),
            contentTitleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            contentTitleLabel.trailingAnchor.constraint(
                equalTo: moreButton.leadingAnchor,
                constant: -8)
        ])
    }
}
