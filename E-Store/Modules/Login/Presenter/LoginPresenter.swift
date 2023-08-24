//
//  LoginPresenter.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import Foundation

protocol LoginPresenter{
    func login(email: String, password: String)
    func validate(email: String, password: String)
}

final class DefaultLoginPresenter {
    private let interactor: LoginInteractor
    private let router: LoginRouter
    private weak var view: loginView!
    
    init(interactor: LoginInteractor, router: LoginRouter, view: loginView!) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension DefaultLoginPresenter: LoginPresenter {
    func login(email: String, password: String) {
        interactor.login(email: email, password: password) { [weak self] (result) in
            switch result {
            case .success:
                self?.router.finish()
            case .failure(let error):
                self?.view.setError(message: error.localizedDescription)
            }
//            self?.router
        }
    }
    func validate(email: String, password: String) {
        let isValid = interactor.validate(email: email, password: password)
        view.setLoginButton(enabled: isValid)
    }
}
