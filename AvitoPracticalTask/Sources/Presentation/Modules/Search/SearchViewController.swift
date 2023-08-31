//
//  SearchViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func updateContent()
    func showAlert()
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
        view.backgroundColor = ColorSet.backgroundColor
        view.addSubviewsDeactivateAutoMask(contentCollectionView)
        presenter.getContent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    // MARK: - @objc Methods

    @objc private func tuppedMoreButton(_ sender: UIButton) {
        print("1")
        guard let cell = sender.superview as? ContentCell else { return }
        print("2")
        guard let indexPath = contentCollectionView.indexPath(for: cell) else { return }
        print("3")
        let selectedModel = presenter.content[indexPath.row]
        print(selectedModel.id ?? "495")
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
}

    // MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !presenter.loading {
           return presenter.content.count
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !presenter.loading {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentCell.cellID,
                for: indexPath) as? ContentCell else {
                return UICollectionViewCell()
            }
            let content = presenter.content[indexPath.row]
            cell.configure(self, model: content, action: #selector(tuppedMoreButton(_:)))
            
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

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !presenter.loading {
            guard let  itemId = presenter.content[indexPath.row].id else { return }
            presenter.configureDetailView(itemId)
        } else {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offsets = Constants.horizontalOffset * 2 + Constants.horizontalOffset / 2
        return CGSize(
            width: (collectionView.frame.size.width - offsets) / 2,
            height: collectionView.frame.size.height / 2.5)
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

    func showAlert() {
        print("Error")
    }

    func transition(to view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
