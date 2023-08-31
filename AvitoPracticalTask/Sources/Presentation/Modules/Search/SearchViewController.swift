//
//  SearchViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func updateContent()
    func changeAndUpdateContent(_ indexPath: IndexPath)
    func showAlert(_ alert: UIAlertController)
    func transition(to: UIViewController)
}

final class SearchViewController: UIViewController {
    // MARK: - Private Properties

    private let presenter: SearchViewPresenter

    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constants.spacing
        layout.minimumLineSpacing = Constants.spacing
        
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
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    // MARK: - Init

    init(presenter: SearchViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorSet.background
        view.addSubviewsDeactivateAutoMask(contentCollectionView)
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPress))
        contentCollectionView.addGestureRecognizer(longPress)
        presenter.getContent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    // MARK: - @objc Methods
    
    @objc private func longPress(
        longPressGestureRecognizer: UILongPressGestureRecognizer) {
        switch presenter.loadingStatus {
        case .loading, .notLoaded:
            break
        case .loaded:
            if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
                let touchPoint = longPressGestureRecognizer
                    .location(in: contentCollectionView)
                guard let indexPath = contentCollectionView
                    .indexPathForItem(at: touchPoint) else { return }
                presenter.showAlertAboutItem(indexPath)
            }
        
        }
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
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    // MARK: - LocalConstants

    private enum LocalConstants {
        static let mockCellCount = 50
    }
}

    // MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch presenter.loadingStatus {
        case .loading, .notLoaded:
            return LocalConstants.mockCellCount
        case .loaded:
            return presenter.content.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch presenter.loadingStatus {
        case .loading, .notLoaded:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SkeletonCell.cellID,
                for: indexPath) as? SkeletonCell else { return UICollectionViewCell() }
            return cell
        case .loaded:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentCell.cellID,
                for: indexPath) as? ContentCell else { return UICollectionViewCell() }
            let content = presenter.content[indexPath.row]
            cell.configure(
                title: content.title,
                price:  content.price,
                address: content.location,
                date: presenter.formatedDate(content.createdDate),
                imageUrl: content.imageUrl)
            return cell
        }
    }
}

    // MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch presenter.loadingStatus {
        case .loading, .notLoaded:
            collectionView.deselectItem(at: indexPath, animated: true)
        case .loaded:
            guard let  itemId = presenter.content[indexPath.row].id else { return }
            presenter.configureDetailView(itemId)
        }
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offsets = Constants.horizontalOffset * 2 + Constants.horizontalOffset / 2
        return CGSize(
            width: (collectionView.frame.size.width - offsets) / 2,
            height: collectionView.frame.size.height / 2.4)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: Constants.horizontalOffset / 2,
            left: Constants.horizontalOffset,
            bottom: Constants.horizontalOffset / 2,
            right: Constants.horizontalOffset)
    }
}

    // MARK: - FirstViewProtocol

extension SearchViewController: SearchViewProtocol {
    func updateContent() {
        DispatchQueue.main.async {
            self.contentCollectionView.reloadData()
        }
    }
    
    func changeAndUpdateContent(_ indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.contentCollectionView.deleteItems(at: [indexPath])
            self.contentCollectionView.reloadData()
            
        }
    }

    func showAlert(_ alert: UIAlertController) {
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }

    func transition(to view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
