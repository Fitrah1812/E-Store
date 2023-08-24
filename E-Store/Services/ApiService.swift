//
//  ApiService.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import Foundation
import Alamofire
import Moya
import RxSwift


class ApiService {
    let configuration = NetworkLoggerPlugin.Configuration(logOptions: .default)
    private lazy var apiProvider: MoyaProvider<Api> = {
        return MoyaProvider<Api>(
            plugins: [NetworkLoggerPlugin(configuration: configuration)]
        )
    }()
    
//
//    private let apiProvider: MoyaProvider<Api> = MoyaProvider<Api>()
    private let disposeBag = DisposeBag()
    
    func login(email: String, password: String, completion: @escaping (Result<AccessToken, Error>) -> Void){
        
        apiProvider.rx.request(.login(email, password))
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    if(200...299).contains(response.statusCode),
                      let accessToken = try? JSONDecoder().decode(AccessToken.self, from: response.data){
                        completion(.success(accessToken))
                    }else {
                        let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Wrong email or password"])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }.disposed(by: disposeBag)
    }
    
    func loadCategoryList(completion: @escaping ([Category]) -> Void) {
        apiProvider.rx.request(.categories)
            .map([Category].self)
            .subscribe { (event) in
                switch event {
                case .success(let categories):
                    completion(categories)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
            .disposed(by: disposeBag)
    
        
        
//        AF.request(BASE_URL + "/api/v1/categories", method: .get)
//            .responseDecodable(of: [Category].self) { response in
//                switch response.result {
//                case .success(let categories):
//                    completion(categories)
//                case .failure(let error):
//                    print(error)
//                    completion([])
//                }
//            }
        
        
        
//        let url = URL(string: "\(BASE_URL)/v1/categories")!
//        let request = URLRequest(url: url)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
//            if let data = data {
//                let categoryList = (try? JSONDecoder().decode([Category].self, from: data)) ?? []
//                DispatchQueue.main.async {
//                    completion(categoryList)
//                }
//            }else{
//                DispatchQueue.main.async {
//                    completion([])
//                }
//            }
//        }
//        task.resume()
    }
    
    func loadProfile(completion: @escaping (Profile?) -> Void){
        apiProvider.rx.request(.profile)
            .map(Profile.self)
            .subscribe { (event) in
                switch event {
                case .success(let profile):
                    completion(profile)
                case .failure(let error):
                    print(String(describing: error))
                    completion(nil)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    func loadProductsByCategory(categoryId: Int, completion: @escaping ([Product]) -> Void){
        apiProvider.rx.request(.products(categoryId))
            .map([Product].self)
            .subscribe { (event) in
                switch event {
                case .success(let products):
                    completion(products)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
            .disposed(by: disposeBag)
    }
    
    func deleteProduct(productId: Int, completion: @escaping (Bool) -> Void){
        apiProvider.rx.request(.deleteProduct(productId))
            .subscribe { (event) in
                switch event {
                case .success:
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
            }
            .disposed(by: disposeBag)
    }
}
