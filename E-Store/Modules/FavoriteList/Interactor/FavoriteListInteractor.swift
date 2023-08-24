//
//  FavoriteListInteractor.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import Foundation

protocol FavoriteListInteractor {
    func fetchFavorites() -> [Product]
    func deleteFavorite(productId: Int)
    
}

final class DefaultFavoriteListInteractor {
    private let favoriteRepository: FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository = FavoriteRepository.shared) {
        self.favoriteRepository = favoriteRepository
    }
}

extension DefaultFavoriteListInteractor: FavoriteListInteractor {
    func fetchFavorites() -> [Product] {
        return favoriteRepository.fetchFavorites().sorted{ p0, p1 in
            return p0.id < p1.id
        }
    }
    
    func deleteFavorite(productId: Int) {
        favoriteRepository.deleteFavorite(productId: productId)
    }
}
