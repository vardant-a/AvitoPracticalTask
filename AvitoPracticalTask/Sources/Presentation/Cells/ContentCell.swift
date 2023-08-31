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

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
    
        return indicator
    }()

    private var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        
        return imageView
    }()

    private var contentTitleLabel = StandardLabel(
        fontOfSize: FontSet.cellH1, numberOfLines: 2)

    private var priceLabel = StandardLabel(
        fontOfSize: FontSet.cellH1Bold, numberOfLines: 2)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubviewsDeactivateAutoMask(
            contentImageView, contentTitleLabel, priceLabel)
        contentImageView.addSubviewsDeactivateAutoMask(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        startingCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        layer.cornerRadius = Constants.cornerRadius
        contentImageView.layer.cornerRadius = Constants.cornerRadius
    }

    // MARK: - Public Methods

    func configure(title: String?, price: String?, imageUrl: String?) {
        contentTitleLabel.text = title
        priceLabel.text = price
        activityIndicator.startAnimating()
        Task {
            guard let stringUrl = imageUrl else { return }
            let result = await NetworkManager().fetchImage(stringUrl)
            switch result {
            case .success(let success):
                contentImageView.image = UIImage(data: success)
                activityIndicator.stopAnimating()
            case .failure(_):
                contentImageView.backgroundColor = ColorSet.tabBarColor
            }
        }
    }
    
    // MARK: - Private Methods

    private func startingCell() {
        contentImageView.image = nil
        contentTitleLabel.text = nil
        priceLabel.text = nil
        activityIndicator.startAnimating()
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
            
            activityIndicator.centerXAnchor.constraint(
                equalTo: contentImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: contentImageView.centerYAnchor),
            
            contentTitleLabel.topAnchor.constraint(
                equalTo: contentImageView.bottomAnchor,
                constant: LocalConstants.lowVerticalOffset),
            contentTitleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            contentTitleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -LocalConstants.bigHorizontalOffset),
            contentTitleLabel.heightAnchor.constraint(
                equalToConstant: 40),
            priceLabel.topAnchor.constraint(
                equalTo: contentTitleLabel.bottomAnchor,
                constant: LocalConstants.lowVerticalOffset),
            priceLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor)
        ])
    }

    // MARK: - LocalConstants

    private enum LocalConstants {
        static let lowVerticalOffset: CGFloat = 4
        static let bigHorizontalOffset: CGFloat = 30
        static let numberOfLine: CGFloat = 2
    }
}
