//
//  ProductListInteractor.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import Foundation

protocol ProductListInteractor {
    func loadProductList(categoryId: Int, completion: @escaping ([Product]) -> Void)
    func deleteProduct(productId: Int, completion: @escaping (Bool) -> Void)
    func saveFavorite(_ product: Product)
}

final class DefaultProductListInteractor {
    private let apiService: ApiService
    private let favoriteRepository: FavoriteRepository
    
    init(apiService: ApiService, favoriteRepository: FavoriteRepository =  FavoriteRepository.shared) {
        self.apiService = apiService
        self.favoriteRepository = favoriteRepository
    }
}

extension DefaultProductListInteractor: ProductListInteractor {
    
    func loadProductList(categoryId: Int, completion: @escaping ([Product]) -> Void) {
        apiService.loadProductsByCategory(categoryId: categoryId, completion: completion)
    }
    
    func deleteProduct(productId: Int, completion: @escaping (Bool) -> Void) {
        apiService.deleteProduct(productId: productId, completion: completion)
    }
    
    func saveFavorite(_ product: Product) {
        favoriteRepository.saveFavorite(product)
    }
}
