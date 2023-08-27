//
//  DetailPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import Foundation

protocol DetailViewPresenter: AnyObject {
    init()
    func inject(view: DetailViewProtocol)
    func showContent()
}

final class DetailPresenter {
    // MARK: - Private Properties

    private weak var view: DetailViewProtocol?

    // MARK: - Init

    init() {}
    
    func inject(view: DetailViewProtocol) {
        if self.view == nil {
            self.view = view
        }
    }
}
    // MARK: - DetailViewPresenter

extension DetailPresenter: DetailViewPresenter {
    func showContent() {
        view?.update()
    }
}
