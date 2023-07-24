//
//  MainNavigationController.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 22/07/2023.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .meliYellow
        navigationBar.tintColor = .black
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .meliYellow
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }

        let rootViewController = SearchViewController()
        setViewControllers([rootViewController], animated: false)
    }
}
