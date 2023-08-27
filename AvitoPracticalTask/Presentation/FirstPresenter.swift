//
//  FirstPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

protocol FirstViewPresenter: AnyObject {
    var loading: Bool { get }
    var content: [Advertisement] { get }

    init(networkService: NetworkService)

    func inject(view: FirstViewProtocol?)
    func getContent()
}

final class FirstPresenter {

    // MARK: - Private Properties

    private weak var view: FirstViewProtocol?
    
    private let networkService: NetworkService
    
    private var loadingStatus = true

    private var dataSource: [Advertisement] = []

    // MARK: - Init
    
    required init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Private Methods
}

extension FirstPresenter: FirstViewPresenter {
    var loading: Bool {
        return loadingStatus
    }
    
    var content: [Advertisement] {
        return dataSource
    }
    
    func inject(view: FirstViewProtocol?) {
        if self.view == nil {
            self.view = view
        }
    }
    
    func getContent() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            self.fetch()
        }
    }
    
    private func fetch() {
        let networkService = NetworkService()
        Task {
           let networkData = await networkService.fetch(
                Request(),
                model: AdvertisementsResponse.self)
            switch networkData {
            case .success(let success):
                guard let advertisements = success.advertisements else { return }
                dataSource = advertisements
                loadingStatus = false
                view?.updateContent()
            case .failure( _):
                view?.showAlert()
            }
        }
    }
}
