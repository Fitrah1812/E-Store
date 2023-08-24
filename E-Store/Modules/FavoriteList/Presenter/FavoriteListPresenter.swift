//
//  FavoriteListPresenter.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import Foundation

protocol FavoriteListPresenter {
    func loadFavoriteList()
    func numberOfFavorites() -> Int
    func productTitle(at index: Int) -> String
    func productDescription(at index: Int) -> String
    func productPrice(at index: Int) -> String
    func deleteFavorite(at index: Int)
    
}

final class DefaultFavoriteListPresenter {
    private let interactor: FavoriteListInteractor
    private let router: FavoriteListRouter
    private let view: FavoriteListView?
    
    private var favoriteList: [Product] = []
    
    init(interactor: FavoriteListInteractor, router: FavoriteListRouter, view: FavoriteListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.favoriteAdded(_:)), name: .favoriteAdded, object: nil)
    }
    
    @objc func favoriteAdded(_ sender: Any){
        loadFavoriteList()
    }
}

extension DefaultFavoriteListPresenter: FavoriteListPresenter {
    func loadFavoriteList() {
        favoriteList = interactor.fetchFavorites()
        view?.reloadData()
    }
    
    func numberOfFavorites() -> Int {
        return favoriteList.count
    }
    
    func productTitle(at index: Int) -> String {
        return favoriteList[index].title
    }
    
    func productDescription(at index: Int) -> String {
        return favoriteList[index].description
    }
    
    func productPrice(at index: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: favoriteList[index].price)) ?? ""
    }
    
    func deleteFavorite(at index: Int) {
        let product = favoriteList.remove(at: index)
        interactor.deleteFavorite(productId: product.id)
    }
    
    
    
  
    
    
}
