//
//  MainRouter.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import Foundation
import UIKit

protocol MainRouter {
    func start() -> UIViewController
}

final class DefaultMainRouter {
    private var tabBarController: UITabBarController!
}

extension DefaultMainRouter: MainRouter {
    func start() -> UIViewController {
        let mainViewController = MainViewController()
        
        let viewController0 = DefaultCategoryListRouter().start()
        let viewController1 = DefaultFavoriteListRouter().start()
        let viewController2 = DefaultProfileRouter().start()
//        if #available(iOS 13.0, *) {
//            viewController0.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
//
//            viewController1.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
//
//        }

        mainViewController.viewControllers = [viewController0, viewController1, viewController2]
        self.tabBarController = mainViewController
        return mainViewController
    }
    
    
}

