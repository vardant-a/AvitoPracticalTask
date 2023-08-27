//
//  DetailViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func update()
}

final class DetailViewController: UIViewController {

    // MARK: - Private Properties

    private var presenter: DetailViewPresenter

    // MARK: - Init

    init(presenter: DetailViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showContent()
        view?.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    // MARK: - Layout

    private func setupLayout() {}
}

    // MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func update() {
        print("update")
    }
}
