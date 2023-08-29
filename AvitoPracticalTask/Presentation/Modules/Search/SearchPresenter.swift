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

    init(networkService: RequestManager)

    func inject(view: SearchViewProtocol?)
    func getContent()
    func configureDetailView(_ itemId: String)
}

final class SearchPresenter {
    // MARK: - Private Properties

    private weak var view: SearchViewProtocol?
    
    private let networkService: RequestManager
    
    private var loadingStatus = true

    private var dataSource: [Advertisement] = []

    // MARK: - Init
    
    required init(networkService: RequestManager) {
        self.networkService = networkService
    }

    // MARK: - Private Methods

    private func fetch() {
        Task {
            let networkData = await networkService.fetchAllData()
            switch networkData {
            case .success(let success):
                guard let advertisements = success.advertisements else { return }
                dataSource = advertisements
                loadingStatus = false
                view?.updateContent()
            case .failure(_):
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
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            self.fetch()
        }
    }

    func configureDetailView(_ itemId: String) {
        let presenter = DetailPresenter(
            itemId: itemId,
            networkService: networkService)
        let controller = DetailViewController(presenter: presenter)
        presenter.inject(view: controller)
        view?.transition(to: controller)
    }
}
