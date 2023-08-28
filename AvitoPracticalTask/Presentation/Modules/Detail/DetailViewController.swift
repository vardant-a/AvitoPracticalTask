//
//  DetailViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import SwiftUI

protocol DetailViewProtocol: AnyObject {
    func update()
    func showContent(_ model: Advertisement)
}

final class DetailViewController: UIViewController {

    // MARK: - Private Properties

    private var presenter: DetailViewPresenter
    
    private var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
    
        return imageView
    }()

    private var priceDetailLabel = StandardLabel(.heightTitle)
    private var detailTitleLabel = StandardLabel(.heightTitle)

    // MARK: - Private lazy Properties

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            detailImageView, priceDetailLabel, detailTitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
    
        return stackView
    }()
    
    private lazy var callButton = StandardButton(
        self,
        title: "Call",
        titleColor: .white,
        buttonColor: .systemGreen,
        action: #selector(tuppedCallButton))

    private lazy var writeButton = StandardButton(
        self,
        title: "Write",
        titleColor: .white,
        buttonColor: .systemBlue,
        action: #selector(tuppedWriteButton))

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
        configureNavigationBar()
        priceDetailLabel.text = "5 000 RUB"
        detailTitleLabel.text = "Low Title for GradientLayer"
        view?.backgroundColor = .darkGray
        view.addSubviewsDeactivateAutoMask(
            contentStackView, callButton, writeButton)
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

    // MARK: - Private Methods

    private func configureNavigationBar() {
        let shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(tuppedShareButton))
        let favoriteItemButton = UIBarButtonItem(title: "favorite", style: .plain, target: self, action: #selector(tuppedFavoriteButton))
        navigationItem.rightBarButtonItems = [favoriteItemButton, shareButton]
    }

    // MARK: - @Objc Methods

    @objc private func tuppedCallButton() {
        presenter.showContent()
    }

    @objc private func tuppedWriteButton() {
        print("Write")
    }

    @objc private func tuppedShareButton() {
        print("Share")
    }

    @objc private func tuppedFavoriteButton() {
        print("favorite")
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            contentStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
////    
//        NSLayoutConstraint.activate([
//            detailImageView.widthAnchor.constraint(equalToConstant: contentStackView.frame.width),
//            detailImageView.heightAnchor.constraint(equalToConstant: 200)
//        ])
        
//        setupConstraintForStackViewSubview(priceDetailLabel)
//        setupConstraintForStackViewSubview(detailTitleLabel)
        
        NSLayoutConstraint.activate([
            callButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            callButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8)
        ])
    
        NSLayoutConstraint.activate([
            writeButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20),
            writeButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            writeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupConstraintForStackViewSubview(_ subview: UIView) {
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(
                equalTo: contentStackView.leadingAnchor,
                constant: 16),
            subview.trailingAnchor.constraint(
                equalTo: contentStackView.trailingAnchor,
                constant: -16)
        ])
    }
}

    // MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func update() {
        print("update")
    }
    
    func showContent(_ model: Advertisement) {
        detailTitleLabel.text = model.title
    }
}

struct DetialControllerProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(
                rootViewController: DetailViewController(
                    presenter: DetailPresenter()))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
