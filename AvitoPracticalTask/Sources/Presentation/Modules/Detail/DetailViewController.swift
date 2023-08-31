//
//  DetailViewController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import SwiftUI
import MapKit

protocol DetailViewProtocol: AnyObject {
    func update(_ image: UIImage?, title: String?, price: String?, description: String?,
                location: String?, address: String?, date: String?)
    func setupMapPoint(annotation: MKPointAnnotation, region: MKCoordinateRegion)
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

    private var priceLabel = StandardLabel(
        fontOfSize: FontSet.targetText, numberOfLines: 2)
    private var titleLabel = StandardLabel(
        fontOfSize: FontSet.textH1, numberOfLines: 2)
    private var descriptionSectionLabel = StandardLabel(
        Localizable.Element.descriptionLabel, fontOfSize: FontSet.textH2)
    private var descriptionLabel = StandardLabel(fontOfSize: FontSet.textH4)
    
    private var locationLabel = StandardLabel(fontOfSize: FontSet.textH4)
    private var addressLabel = StandardLabel(fontOfSize: FontSet.textH4)
    
    private let mapView = MKMapView()

    // MARK: - Private lazy Properties
    
    private lazy var callButton = StandardButton(
        self,
        title: Localizable.Element.callButton,
        titleColor: .white,
        buttonColor: .systemGreen,
        action: #selector(tuppedCallButton))

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
        priceLabel.text = "Price"
        titleLabel.text = "Title"
        titleLabel.numberOfLines = 2
        view.backgroundColor =  ColorSet.background
        view.addSubviewsDeactivateAutoMask(
            detailImageView, priceLabel, titleLabel,
            descriptionSectionLabel, descriptionLabel,
            mapView, callButton)
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
    }

    // MARK: - @Objc Methods

    @objc private func tuppedCallButton() {
        presenter.call()
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
                equalToConstant: 250),
            
            priceLabel.topAnchor.constraint(
                equalTo: detailImageView.bottomAnchor,
                constant: Constants.verticalOffset / 2),
            priceLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            priceLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            titleLabel.topAnchor.constraint(
                equalTo: priceLabel.bottomAnchor,
                constant: Constants.verticalOffset / 2),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            
            descriptionSectionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.verticalOffset),
            descriptionSectionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant:
                    Constants.horizontalOffset),
            descriptionSectionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: descriptionSectionLabel.bottomAnchor,
                constant: Constants.verticalOffset / 2),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            
            callButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.verticalOffset),
            callButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            callButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            
            mapView.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Constants.verticalOffset),
            mapView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalOffset),
            mapView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalOffset),
            mapView.bottomAnchor.constraint(
                equalTo: callButton.topAnchor,
                constant: -Constants.verticalOffset)
        ])
    }
}

    // MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func update(_ image: UIImage?, title: String?, price: String?, description: String?,
                location: String?, address: String?, date: String?) {
        DispatchQueue.main.async {
            self.detailImageView.image = image
            self.titleLabel.text = title
            self.priceLabel.text = price
            self.descriptionLabel.text = description
        }
    }
    
    func setupMapPoint(annotation: MKPointAnnotation, region: MKCoordinateRegion) {
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    struct DetialControllerProvider: PreviewProvider {
        static var previews: some View {
            ViewControllerPreview {
                UINavigationController(
                    rootViewController: DetailViewController(
                        presenter: DetailPresenter(
                            itemId: "2",
                            networkService: NetworkManager(),
                            stringValidatorService: StringValidator())))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
