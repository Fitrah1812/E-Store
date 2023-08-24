//
//  Api.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import Foundation
import Moya

enum Api {
    case categories
    case products(Int)
    case deleteProduct(Int)
    case login(String, String)
    case profile
}
let BASE_URL = "https://api.escuelajs.co"


extension Api: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "/api/v1/categories"
        case .products:
            return "/api/v1/products"
        case .deleteProduct(let productId):
            return "/api/v1/products/\(productId)"
        case .login:
            return "/api/v1/auth/login"
        case .profile:
            return "/api/v1/auth/profile"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories, .products, .profile:
            return .get
        case .deleteProduct:
            return .delete
        case .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .categories:
            return .requestPlain
        case .products(let categoryId):
            return .requestParameters(parameters: ["categoryId": categoryId], encoding: URLEncoding.default)
        case .deleteProduct:
            return .requestPlain
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .profile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        if let accessToken = TokenRepository(apiService: ApiService()).getAccessToken()?.accessToken{
            return ["Authorization": "Bearer \(accessToken)"]
        }else {
            return nil
        }
        
//        switch self {
//        case .categories, .products, .deleteProduct, .login:
//            return nil
//
//        }
    }
}
