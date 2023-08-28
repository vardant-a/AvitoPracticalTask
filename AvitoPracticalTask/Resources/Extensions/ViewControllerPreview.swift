//
//  ViewControllerPreview.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    
    let viewControllerGenerator: () -> UIViewController
    
    init(viewControllerGenerator: @escaping () -> UIViewController) {
        self.viewControllerGenerator = viewControllerGenerator
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerGenerator()
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context) {}
}
