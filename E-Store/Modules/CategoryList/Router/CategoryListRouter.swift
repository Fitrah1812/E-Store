//
//  CategoryListRouter.swift
//  E-Store
//
//  Created by Laptop MCO on 09/08/23.
//

import UIKit

protocol CategoryListRouter {
    func start() -> UIViewController
    func showProductList(category: Category)
}

final class DefaultCategoryListRouter {
    private var navigationController: UINavigationController!
    
}

extension DefaultCategoryListRouter: CategoryListRouter {
    func start() -> UIViewController {
        let viewController = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
        let interactor = DefaultCategoryListInteractor(apiService: ApiService())
        let router = self
        let presenter = DefaultCategoryListPresenter(interactor: interactor, router: router, view: viewController)
    
        viewController.presenter = presenter
        
        
        self.navigationController = navigationController
        
        
        return navigationController
        
    }
    
    func showProductList(category: Category) {
        let ViewController = ProductListRouter.create(category: category)
        navigationController.pushViewController(ViewController, animated: true)
    }
}
