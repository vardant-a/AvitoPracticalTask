//
//  DetailPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import Foundation
import UIKit

protocol DetailViewPresenter: AnyObject {
    init(itemId: String, networkService: NetworkManager, stringValidatorService: StringValidatorService)
    
    func inject(view: DetailViewProtocol)
    func showContent()
    func call()
}

final class DetailPresenter {
    // MARK: - Private Properties

    private weak var view: DetailViewProtocol?
    
    private let networkService: NetworkManager
    private let stringValidatorService: StringValidatorService

    private let itemId: String

    private var item: Advertisement = Advertisement()

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
}
    // MARK: - DetailViewPresenter

extension DetailPresenter: DetailViewPresenter {
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
    
    func showContent() {
        Task {
            let networkResult = await networkService.fetchDetails(itemId: itemId)
            switch networkResult {
            case .success(let success):
                await view?.update(
                    getImage(success),
                    title: success.title ?? "title",
                    price: success.price ?? "1")
                item = success
            case .failure(_):
                print("1")
            }
        }
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
}
