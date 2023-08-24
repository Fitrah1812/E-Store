//
//  TokenRepository.swift
//  E-Store
//
//  Created by Laptop MCO on 15/08/23.
//

import Foundation

final class TokenRepository {
    private let apiService: ApiService
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getAccessToken() -> AccessToken? {
        if let data = UserDefaults.standard.data(forKey: "kAccessToken") {
            let accessToken = try? JSONDecoder().decode(AccessToken.self, from: data)
            return accessToken
        }
        return nil
    }
    
    func setAccessToken(_ accessToken: AccessToken?){
        if let accessToken = accessToken,
           let data = try? JSONEncoder().encode(accessToken){
            UserDefaults.standard.set(data, forKey: "kAccessToken")
        }else {
            UserDefaults.standard.set(nil, forKey: "kAccessToken")
        }
        UserDefaults.standard.synchronize()
    }
    
    
    func login(email: String, password: String, compeletion: @escaping(Error?) -> Void){
        apiService.login(email: email, password: password){ (result) in
            switch result {
            case .success(let accessToken):
                self.setAccessToken(accessToken)
                compeletion(nil)
            case .failure(let error):
                compeletion(error)
            }
        }
    }
}
