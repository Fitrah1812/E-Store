//
//  FavoriteListRouter.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

protocol FavoriteListRouter {
    func start() -> UIViewController
}

final class DefaultFavoriteListRouter {
    private var navigationController: UINavigationController!
}

extension DefaultFavoriteListRouter: FavoriteListRouter {
    func start() -> UIViewController {
        let viewController = FavoriteListViewController(nibName: "FavoriteListViewController", bundle: nil)
        
        let interactor = DefaultFavoriteListInteractor()
        let presenter = DefaultFavoriteListPresenter(interactor: interactor, router: self, view: viewController)
        
        viewController.presenter = presenter
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.navigationController = navigationController
        
        return navigationController
    }
    
    
}

