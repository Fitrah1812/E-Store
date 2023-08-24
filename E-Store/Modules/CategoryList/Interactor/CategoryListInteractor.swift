//
//  CategoryListInteractor.swift
//  E-Store
//
//  Created by Laptop MCO on 09/08/23.
//

import Foundation

protocol CategoryListInteractor {
    func loadCategoryList(completion: @escaping ([Category]) -> Void)
}

final class DefaultCategoryListInteractor {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
}

extension DefaultCategoryListInteractor: CategoryListInteractor {
    func loadCategoryList(completion: @escaping ([Category]) -> Void) {
        apiService.loadCategoryList(completion: completion)
    }
    
}
