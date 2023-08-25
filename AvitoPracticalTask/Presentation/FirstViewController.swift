//
//  FirstViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

protocol FirstViewProtocol: AnyObject {
    func updateContent()
}

final class FirstViewController: UIViewController {

    // MARK: - Private Properties

    private let presenter: FirstViewPresenter

    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
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
            SkeletonCell.self,
            forCellWithReuseIdentifier: SkeletonCell.cellID)
        collectionView.register(
            ContentCell.self,
            forCellWithReuseIdentifier: ContentCell.cellID)
        collectionView.backgroundColor = .white

        return collectionView
    }()

    // MARK: - Init

    init(presenter: FirstViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubviewsDeactivateAutoMask(contentCollectionView)
        presenter.startLoading()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !presenter.loading {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentCell.cellID,
                for: indexPath) as? ContentCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(TestModel(title: "\(indexPath.row + 1)"))
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SkeletonCell.cellID,
                for: indexPath) as? SkeletonCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
    }
}

    // MARK: - UICollectionViewDelegate

extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row + 1)")
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offsets = LocalConstants.horizontalOffset * 2 + LocalConstants.horizontalOffset / 2
        return CGSize(
            width: (collectionView.frame.size.width - offsets) / 2,
            height: collectionView.frame.size.height / 2.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: LocalConstants.horizontalOffset / 2,
            left: LocalConstants.horizontalOffset,
            bottom: LocalConstants.horizontalOffset / 2,
            right: LocalConstants.horizontalOffset)
    }
}

    // MARK: - FirstViewProtocol

extension FirstViewController: FirstViewProtocol {
    func updateContent() {
        DispatchQueue.main.async {
            self.contentCollectionView.reloadData()
        }
    }
}
