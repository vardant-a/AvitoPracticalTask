//
//  FirstPresenter.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 24.08.2023.
//

import UIKit

protocol FirstViewPresenter: AnyObject {
    var loading: Bool { get }

    init()

    func inject(view: FirstViewProtocol?)
    func startLoading()
}

final class FirstPresenter {

    // MARK: - Private Properties

    private weak var view: FirstViewProtocol?
    
    private var loadingStatus = true

    // MARK: - Init
    
    required init() {}

    // MARK: - Private Methods
}

extension FirstPresenter: FirstViewPresenter {
    var loading: Bool {
        return loadingStatus
    }
    
    func inject(view: FirstViewProtocol?) {
        if self.view == nil {
            self.view = view
        }
    }
    
    func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.loadingStatus = false
            self.view?.updateContent()
        }
    }
}
