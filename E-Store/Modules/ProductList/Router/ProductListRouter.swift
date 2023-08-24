//
//  ProductListRouter.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import UIKit

class ProductListRouter {
     static func create(category: Category) -> UIViewController {
        let viewController = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
        let interactor = DefaultProductListInteractor(apiService: ApiService())
        let router = ProductListRouter()
        let presenter = DefaultProductListPresenter(interactor: interactor, router: router, view: viewController, category: category)
        
        viewController.presenter = presenter
        return viewController
        
    }
}


