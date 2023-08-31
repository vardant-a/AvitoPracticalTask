//
//  SearchPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

enum LoadingStatus {
    case loading, loaded, notLoaded
}

protocol SearchViewPresenter: AnyObject {
    var loadingStatus: LoadingStatus { get }
    var content: [Advertisement] { get }

    init(networkService: NetworkManager)
    func inject(view: SearchViewProtocol?)

    func getContent()
    func formatedDate(_ inputDateStr: String?) -> String
    func showAlertAboutItem(_ indexPath: IndexPath)
    func configureDetailView(_ itemId: String)
}

final class SearchPresenter {
    private enum AlertActionType {
        case tryNowAndTryLater, settingsAndTryLater
    }

    // MARK: - Private Properties

    private weak var view: SearchViewProtocol?
    
    private let networkService: NetworkManager

    private var dataSource: [Advertisement] = []
    
    private var loadingContentStatus: LoadingStatus = .loading

    // MARK: - Init
    
    required init(networkService: NetworkManager) {
        self.networkService = networkService
    }

    // MARK: - Private Methods

    private func fetch() {
        loadingContentStatus = .loading
        view?.updateContent()
        Task {
            let networkData = await networkService.fetchAllData()
            switch networkData {
            case .success(let success):
                guard let advertisements = success.advertisements else { return }
                dataSource = advertisements
                loadingContentStatus = .loaded
                view?.updateContent()
            case .failure(let failure):
                initFailureEvent(failure)
                loadingContentStatus = .notLoaded
                view?.updateContent()
            }
        }
    }
    


    private func initFailureEvent(_ failure: RequestError) {
        switch failure {
        case .invalidURL, .dataNotReceived:
            view?.showAlert(configureAlert(
                .settingsAndTryLater,
                message: failure.message))
        case .decodeError:
            view?.showAlert(configureAlert(
                .tryNowAndTryLater,
                message: failure.message))
        }
    }
    
    private func configureAlert(_ method: AlertActionType,
                                message: String) -> UIAlertController {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert)
        switch method {
        case .tryNowAndTryLater:
            alert.addActions(configureActions(.tryNowAndTryLater))
        case .settingsAndTryLater:
            alert.addActions(configureActions(.settingsAndTryLater))
        }
        
        return alert
    }
    
    private func configureActions(_ method: AlertActionType) -> [UIAlertAction] {
        let tryNowAction = UIAlertAction(
            title: Localizable.AlertAction.now,
            style: .default) { _ in
                self.fetch()
            }
        let tryLaterAction = UIAlertAction(
            title: Localizable.AlertAction.later,
            style: .cancel)
        let openSettingsAction = UIAlertAction(
            title: Localizable.AlertAction.settings,
            style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(settingsURL) {
                        UIApplication.shared.open(settingsURL, options: [:],
                                                  completionHandler: nil)
                    }
                }
            }
        switch method {
        case .tryNowAndTryLater:
            return [tryNowAction, tryLaterAction]
        case .settingsAndTryLater:
            return [tryNowAction, openSettingsAction]
        }
    }
}
                    
    // MARK: - SearchViewPresenter

extension SearchPresenter: SearchViewPresenter {
    var loadingStatus: LoadingStatus {
        return loadingContentStatus
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
    
    func formatedDate(_ inputDateStr: String?) -> String {
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
    
    func showAlertAboutItem(_ indexPath: IndexPath) {
        let alert = UIAlertController(
            title: content[indexPath.item].address,
            message: nil,
            preferredStyle: .actionSheet)
        let showDetailAction = UIAlertAction(
            title: Localizable.AlertAction.showDetail,
            style: .default) { _ in
            guard let stringId = self.content[indexPath.item].id else { return }
                self.configureDetailView(stringId)
        }
        let deleteAction = UIAlertAction(
            title: Localizable.AlertAction.delete,
            style: .destructive) { _ in
                self.dataSource.remove(at: indexPath.item)
                self.view?.changeAndUpdateContent(indexPath)
        }
            
        let cancelAction = UIAlertAction(
            title: Localizable.AlertAction.cancel ,
            style: .cancel)
        alert.addActions([showDetailAction, deleteAction, cancelAction])
        view?.showAlert(alert)
    
    }

    func configureDetailView(_ itemId: String) {
        let presenter = DetailPresenter(
            itemId: itemId,
            networkService: networkService,
            stringValidatorService: StringValidator())
        let controller = DetailViewController(presenter: presenter)
        presenter.inject(view: controller)
        view?.transition(to: controller)
    }
}
