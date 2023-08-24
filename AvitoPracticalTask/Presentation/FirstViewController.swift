//
//  FirstViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

final class FirstViewController: UIViewController {

    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    // MARK: - Private lazy Properties

    private lazy var contentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ContentCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
        collectionView.backgroundColor = .white

        return collectionView
    }()
    
    // MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubviewsDeactivateAutoMask(contentCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: LocalConstants.verticalOffset),
            contentCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            contentCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            contentCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -LocalConstants.verticalOffset),
        ])
    }
    
    // MARK: - LocalConstants

    private enum LocalConstants {
        static let verticalOffset: CGFloat = 20
        static let horizontalOffset: CGFloat = 16
    }
}

    // MARK: - UICollectionViewDataSource

extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContentCollectionViewCell.cellID,
            for: indexPath) as? ContentCollectionViewCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}

extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row + 1)")
    }
}
