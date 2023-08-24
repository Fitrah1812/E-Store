//
//  ProductListPresenter.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import UIKit

protocol ProductListPresenter{
    func loadCategoryByProductList()
    func numberOfProducts() -> Int
    func productTitle(at index: Int) -> String
    func productDescription(at index: Int) -> String
    func productPrice(at index: Int) -> String
    func categoryName() -> String
    func deleteProduct(at Index: Int)
    func saveFavorite(at index: Int)
}

final class DefaultProductListPresenter {
    let interactor: ProductListInteractor
    let router: ProductListRouter
    weak var view: ProductListView?
    
    private var productList: [Product] = []
    private let category: Category
    
    init(interactor: ProductListInteractor, router: ProductListRouter, view: ProductListView? = nil, category: Category) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.category = category
    }
}


extension DefaultProductListPresenter: ProductListPresenter {
    func loadCategoryByProductList() {
        interactor.loadProductList(categoryId: category.id) { [weak self] (productList) in
            self?.productList = productList
            self?.view?.reloadData()
        }
    }
    
    func numberOfProducts() -> Int {
        return productList.count
    }
    
    func productTitle(at index: Int) -> String {
        return productList[index].title
    }
    
    func productDescription(at index: Int) -> String {
        return productList[index].description
    }
    
    func productPrice(at index: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: productList[index].price)) ?? ""
    }
    
    func categoryName() -> String {
        return category.name
    }
    
//    func deleteProduct(at Index: Int) {
//        let product = productList.remove(at: Index)
//        interactor.deleteProduct(productId: product.id) { (success) in }
////        view?.reloadData()
//    }
    
    func deleteProduct(at Index: Int) {
        let product = productList[Index]
        interactor.deleteProduct(productId: product.id) { [weak self] (success) in
            if success {
                self?.productList.remove(at: Index)
                self?.view?.deleteProduct(at: Index)
            }
        }
    }
    
    func saveFavorite(at index: Int) {
        interactor.saveFavorite(productList[index])
    }
}
