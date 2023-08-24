//
//  LoginInteractor.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import Foundation

protocol LoginInteractor {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func validate(email: String, password: String) -> Bool
}

final class DefaultLoginInteractor {
    private let tokenRepository: TokenRepository
    init(tokenRepository: TokenRepository = TokenRepository(apiService: ApiService())) {
        self.tokenRepository = tokenRepository
    }
    
    
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
    }
    
    func isPasswrodValid(password: String) -> Bool {
        return password.count > 3
    }
}

extension DefaultLoginInteractor: LoginInteractor {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        tokenRepository.login(email: email, password: password) { (error) in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(()))
            }
        }
        completion(.success(()))
    }
    
    func validate(email: String, password: String) -> Bool {
        return isEmailValid(email: email) && isPasswrodValid(password: password)
    }
    
}
