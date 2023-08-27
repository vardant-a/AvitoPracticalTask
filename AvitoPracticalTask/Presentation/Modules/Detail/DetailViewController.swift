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

    
    private var detailTitleLabel = StandardLabel(.heightTitle)

    // MARK: - Private lazy Properties

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
        detailTitleLabel.text = "Low Title for GradientLayer"
        view?.backgroundColor = .white
        view.addSubviewsDeactivateAutoMask(
            detailImageView, detailTitleLabel, callButton, writeButton)
        
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
        detailImageView.addGradientLayer()
        detailTitleLabel.addGradientLayer()
    }

    // MARK: - @Objc Methods

    @objc private func tuppedCallButton() {
        presenter.showContent()
    }

    @objc private func tuppedWriteButton() {
        print("Write")
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            detailImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            detailImageView.heightAnchor.constraint(
                equalToConstant: 300)
        ])

        NSLayoutConstraint.activate([
            callButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20),
            callButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            callButton.trailingAnchor.constraint(
                equalTo: view.centerXAnchor,
                constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            writeButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20),
            writeButton.leadingAnchor.constraint(
                equalTo: view.centerXAnchor,
                constant: 8),
            writeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16)
        ])

        NSLayoutConstraint.activate([
            detailTitleLabel.topAnchor.constraint(
                equalTo: detailImageView.bottomAnchor,
                constant: 8),
            detailTitleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            detailTitleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16)
        ])
    }

    private func test() {
        NSLayoutConstraint.activate([
            detailTitleLabel.topAnchor.constraint(
                equalTo: detailImageView.bottomAnchor,
                constant: 8),
            detailTitleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16),
            detailTitleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
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
            DetailViewController(presenter: DetailPresenter())
        }
        .edgesIgnoringSafeArea(.all)
    }
}
