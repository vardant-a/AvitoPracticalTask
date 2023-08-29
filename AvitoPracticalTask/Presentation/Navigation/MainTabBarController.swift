//
//  MainTabBarController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Private Properties

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
        setupTabBarAppearance()
    }

    // MARK: - Private Methods

    private func configureTab(_ view: UIViewController, title: String, image: UIImage?, tag: Int) -> UINavigationController {
        let controller = MainNavigationController(rootViewController: view)
        controller.tabBarItem = UITabBarItem(
            title: title,
            image: image,
            tag: tag)
        
        return controller
    }

    private func configureTabBar() {
        let searchTab = configureTab(
            searchController,
            title: "Search",
            image: ImageSet.searchTabBarItem,
            tag: 0)
        
        viewControllers = [searchTab]
    }

    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = ColorSet.tabBarItem
        tabBarAppearance.barTintColor = ColorSet.tabBarColor
        tabBarAppearance.backgroundColor = ColorSet.tabBarColor
    }
}
