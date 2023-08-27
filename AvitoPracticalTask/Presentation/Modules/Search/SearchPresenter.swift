//
//  SearchPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

protocol SearchViewPresenter: AnyObject {
    var loading: Bool { get }
    var content: [Advertisement] { get }

    init(networkService: NetworkService)

    func inject(view: SearchViewProtocol?)
    func getContent()
    func configureDetailView()
}

final class SearchPresenter {
    // MARK: - Private Properties

    private weak var view: SearchViewProtocol?
    
    private let networkService: NetworkService
    
    private var loadingStatus = true

    private var dataSource: [Advertisement] = []

    // MARK: - Init
    
    required init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Private Methods

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

extension SearchPresenter: SearchViewPresenter {
    var loading: Bool {
        return loadingStatus
    }
    
    var content: [Advertisement] {
        return dataSource
    }
    
    func inject(view: SearchViewProtocol?) {
        if self.view == nil {
            self.view = view
        }
    }
    
    func getContent() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            self.fetch()
        }
    }

    func configureDetailView() {
        let presenter = DetailPresenter()
        let controller = DetailViewController(presenter: presenter)
        presenter.inject(view: controller)
        view?.transition(to: controller)
    }
}
