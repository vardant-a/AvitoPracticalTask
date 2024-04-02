//
//  DetailPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

protocol DetailViewPresenter: AnyObject {
    var loadingStatus: LoadingStatus { get }
    init(itemId: String, networkService: NetworkManager, stringValidatorService: StringValidatorService)
    func inject(view: DetailViewProtocol)
    
    func getContent()
    func call()
}

final class DetailPresenter {
    
    // MARK: - Private Properties

    private weak var view: DetailViewProtocol?
    
    private let networkService: NetworkManager
    private let stringValidatorService: StringValidatorService

    private let itemId: String

    private var item: Advertisement = Advertisement()
    
    private var loadingContentStatus: LoadingStatus = .loading

    // MARK: - Init

    required init(
        itemId: String, networkService: NetworkManager,
        stringValidatorService: StringValidatorService
    ) {
        self.itemId = itemId
        self.networkService = networkService
        self.stringValidatorService = stringValidatorService
    }
    
    func inject(view: DetailViewProtocol) {
        if self.view == nil {
            self.view = view
        }
    }
    
    // MARK: - Private Methods

    private func formatedDate(_ inputDateStr: String?) -> String {
        guard let inputDateStr = inputDateStr else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        if let inputDate = dateFormatter.date(from: inputDateStr) {
            dateFormatter.dateFormat = "d MMMM yyyy"
            let formattedDateStr = dateFormatter.string(from: inputDate)
            return formattedDateStr
        }
        
        return inputDateStr
    }
    
    private func getImage(_ model: Advertisement?) async -> UIImage? {
        guard let imageUrl = model?.imageUrl else { return nil }
        let result = await NetworkManager().fetchImage(imageUrl)
        switch result {
        case .success(let success):
            return UIImage(data: success)
        case .failure(_):
            return nil
        }
    }
    
    private func geocode(_ cityName: String) {
        guard !cityName.isEmpty else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { placemarks, error in
            if error != nil { return }

            if let location = placemarks?.first?.location?.coordinate {
                self.configureCoordinate(location, cityName: cityName)
            }
        }
    }

    private func configureCoordinate(_ location: CLLocationCoordinate2D, cityName: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = cityName
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000)
        view?.setupMapPoint(annotation: annotation, region: region)
    }
    
    private func fetch() {
        Task {
            let networkResult = await networkService.fetchDetails(itemId: itemId)
            switch networkResult {
            case .success(let success):
                item = success
                await view?.update(
                    getImage(success),
                    title: success.title,
                    price: success.price,
                    description: success.description,
                    location: success.location,
                    address: success.address,
                    date: formatedDate(item.createdDate))
                item = success
                guard let cityName = item.location else { return }
                loadingContentStatus = .loaded
                geocode(cityName)
            case .failure(_):
                break
            }
        }
    }
}
    // MARK: - DetailViewPresenter

extension DetailPresenter: DetailViewPresenter {
    var loadingStatus: LoadingStatus {
        return loadingContentStatus
    }

    func call() {
        guard let phoneNumber = item.phoneNumber else { return }
        let number = stringValidatorService.clearStringValue(phoneNumber)
        
        if let phoneCallURL = URL(string: "tel://" + number) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
    }
    
    func getContent() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            self.fetch()
        }
    }
}
