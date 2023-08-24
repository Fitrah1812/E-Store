//
//  CategoryListPresenter.swift
//  E-Store
//
//  Created by Laptop MCO on 09/08/23.
//

import UIKit

protocol CategoryListPresenter {
    func loadCategoryList()
    func numberOfCategories() -> Int
    func categoryImage(at index: Int) -> String
    func categoryName(at index: Int) -> String
    func selectCategory(at index: Int)
}

final class DefaultCategoryListPresenter {
    let interactor: CategoryListInteractor
    let router: CategoryListRouter
    weak var view: CategoryListView?
    
    private var categoryList: [Category] = []
    
    init(interactor: CategoryListInteractor, router: CategoryListRouter, view: CategoryListView? = nil) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension DefaultCategoryListPresenter: CategoryListPresenter {
    func loadCategoryList() {
        interactor.loadCategoryList { [weak self] (categoryList) in
            self?.categoryList = categoryList
            self?.view?.reloadData()
            
        }
    }
    
    func numberOfCategories() -> Int {
        return categoryList.count
    }
    
    func categoryImage(at index: Int) -> String {
        return categoryList[index].image
    }
    
    func categoryName(at index: Int) -> String {
        return categoryList[index].name
    }
    
    func selectCategory(at index: Int) {
        router.showProductList(category: categoryList[index])
    }
    
    
}
