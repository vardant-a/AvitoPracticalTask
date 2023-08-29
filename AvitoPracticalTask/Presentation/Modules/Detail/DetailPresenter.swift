//
//  DetailPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import Foundation
import UIKit

protocol DetailViewPresenter: AnyObject {
    init(itemId: String, networkService: RequestManager)
    
    func inject(view: DetailViewProtocol)
    func showContent()
    func call()
}

final class DetailPresenter {
    // MARK: - Private Properties

    private weak var view: DetailViewProtocol?
    
    private let networkService: RequestManager

    private let itemId: String

    // MARK: - Init

    required init(itemId: String, networkService: RequestManager) {
        self.itemId = itemId
        self.networkService = networkService
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
        if let phoneCallURL = URL(string: "tel://\(79999999999)") {
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
            case .failure(_):
                print("1")
            }
        }
    }
    
    private func getImage(_ model: Advertisement?) async -> UIImage? {
            guard let imageUrl = model?.imageUrl else { return nil }
            let result = await RequestManager().fetchImage(imageUrl)
            switch result {
            case .success(let success):
                return UIImage(data: success)
            case .failure(_):
                return nil
            }
    }
}
