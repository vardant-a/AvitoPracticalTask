//
//  MainNavigationController.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 28.08.2023.
//

import UIKit

final class MainNavigationController: UINavigationController {
    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle(
            rawValue: topViewController?.preferredStatusBarStyle
                .rawValue ?? .max) ?? .default
    }
    
    // MARK: - Init
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavBarAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = ColorSet.backgroundColor
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.green]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.orange]
//
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .brown
        UINavigationBar.appearance().prefersLargeTitles = false
    }
}
