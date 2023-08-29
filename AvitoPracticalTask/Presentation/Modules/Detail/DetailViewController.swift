//
//  DetailViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import SwiftUI

protocol DetailViewProtocol: AnyObject {
    func update(_ image: UIImage?)
    func showContent(_ model: Advertisement)
}

final class DetailViewController: UIViewController {

    // MARK: - Private Properties

    private var presenter: DetailViewPresenter
    
    private var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    
        return imageView
    }()

    private var priceDetailLabel = StandardLabel(.heightTitle)
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
        configureNavigationBar()
        priceDetailLabel.text = "Price"
        detailTitleLabel.text = "Title"
        detailTitleLabel.numberOfLines = 2
        view.backgroundColor =  ColorSet.backgroundColor
        view.addSubviewsDeactivateAutoMask(
            detailImageView, priceDetailLabel, detailTitleLabel,
            callButton, writeButton)
        presenter.showContent()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: ImageSet.backArrow,
            style: .plain,
            target: self,
            action: #selector(tuppedBackButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: ImageSet.share,
            style: .plain,
            target: self,
            action: #selector(tuppedShareButton))
    }

    // MARK: - @Objc Methods

    @objc private func tuppedCallButton() {
        presenter.call()
    }

    @objc private func tuppedWriteButton() {
        print("write")
    }

    @objc private func tuppedShareButton() {
        print("Share")
    }

    @objc private func tuppedBackButton() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            detailImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            detailImageView.heightAnchor.constraint(
                equalToConstant: 330),
            
            priceDetailLabel.topAnchor.constraint(
                equalTo: detailImageView.bottomAnchor,
                constant: Constants.verticalOffset / 2),
            priceDetailLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            priceDetailLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            detailTitleLabel.topAnchor.constraint(
                equalTo: priceDetailLabel.bottomAnchor,
                constant: Constants.verticalOffset / 2),
            detailTitleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            detailTitleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            
            callButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.verticalOffset),
            callButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            callButton.trailingAnchor.constraint(
                equalTo: view.centerXAnchor,
                constant: -Constants.horizontalOffset / 2),
            
            writeButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.verticalOffset),
            writeButton.leadingAnchor.constraint(
                equalTo: view.centerXAnchor,
                constant: Constants.horizontalOffset / 2),
            writeButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset)
        ])
    }
}

    // MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func update(_ image: UIImage?) {
        print("update")
        DispatchQueue.main.async {
            self.detailImageView.image = image
        }
    }
    
    func showContent(_ model: Advertisement) {
        DispatchQueue.main.async {
            self.detailTitleLabel.text = model.title
            self.priceDetailLabel.text = model.price
        }
    }
}

struct DetialControllerProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(
                rootViewController: DetailViewController(
                    presenter: DetailPresenter(
                        itemId: "2",
                        networkService: RequestManager())))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
