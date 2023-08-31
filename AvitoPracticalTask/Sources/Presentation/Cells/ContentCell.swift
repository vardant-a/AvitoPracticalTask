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
        imageView.backgroundColor = ColorSet.main
        imageView.clipsToBounds = true
        
        return imageView
    }()

    private var contentTitleLabel = StandardLabel(
        fontOfSize: FontSet.cellH1,
        numberOfLines: LocalConstants.numberOfLine)

    private var priceLabel = StandardLabel(
        fontOfSize: FontSet.cellTargetText,
        numberOfLines: LocalConstants.numberOfLine)

    private var addressLabel = StandardLabel(
        color: ColorSet.second,
        fontOfSize: FontSet.cellH4,
        numberOfLines: 1)

    private var dateLabel = StandardLabel(
        color: ColorSet.second,
        fontOfSize: FontSet.cellH4,
        numberOfLines: 1)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubviewsDeactivateAutoMask(
            contentImageView, contentTitleLabel, priceLabel,
            addressLabel, dateLabel)
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

    func configure(title: String?, price: String?, address: String?, date: String?, imageUrl: String?) {
        contentTitleLabel.text = title
        priceLabel.text = price
        addressLabel.text = address
        dateLabel.text = date
        activityIndicator.startAnimating()
        getAndSetupImage(by: imageUrl)
    }
    
    // MARK: - Private Methods

    private func startingCell() {
        contentImageView.image = nil
        contentTitleLabel.text = nil
        priceLabel.text = nil
        addressLabel.text = nil
        dateLabel.text = nil
        activityIndicator.startAnimating()
    }

    private func getAndSetupImage(by imageUrl: String?) {
        Task {
            guard let stringUrl = imageUrl else { return }
            let result = await NetworkManager().fetchImage(stringUrl)
            switch result {
            case .success(let success):
                contentImageView.image = UIImage(data: success)
                activityIndicator.stopAnimating()
            case .failure(_):
                break
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
                equalToConstant: LocalConstants.titleHeight),
            
            priceLabel.topAnchor.constraint(
                equalTo: contentTitleLabel.bottomAnchor,
                constant: LocalConstants.lowVerticalOffset),
            priceLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            
            addressLabel.topAnchor.constraint(
                equalTo: priceLabel.bottomAnchor,
                constant: LocalConstants.lowVerticalOffset),
            addressLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            
            dateLabel.topAnchor.constraint(
                equalTo: addressLabel.bottomAnchor,
                constant: LocalConstants.lowVerticalOffset),
            dateLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor)
        ])
    }

    // MARK: - LocalConstants

    private enum LocalConstants {
        static let lowVerticalOffset: CGFloat = 4
        static let bigHorizontalOffset: CGFloat = 30
        static let titleHeight: CGFloat = 40
        static let numberOfLine = 2
    }
}
