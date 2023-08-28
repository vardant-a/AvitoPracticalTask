//
//  MainTabBarController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private var searchController: SearchViewController = {
        let networkService = RequestManager()
        let presenter = SearchPresenter(networkService: networkService)
        let searchController = SearchViewController(presenter: presenter)
        presenter.inject(view: searchController)
    
        return searchController
    }()

    // MARK: - Life Cycles Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    // MARK: - Private Methods

    private func configureTab(_ view: UIViewController, title: String) -> UINavigationController {
        let controller = UINavigationController(rootViewController: view)
        controller.tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        
        return controller
    }

    private func configureTabBar() {
        let searchTab = configureTab(searchController, title: "Search")
        
        viewControllers = [searchTab]
    }
}
