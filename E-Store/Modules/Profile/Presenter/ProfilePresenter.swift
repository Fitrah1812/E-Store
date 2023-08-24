//
//  PresenterInteractor.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import Foundation

protocol ProfilePresenter {
    func loadProfile()
    func presentLogin()
    var avatar: String { get }
    var email: String { get }
    var name: String { get }
}

final class DefaultProfilePresenter {
    private let interactor: ProfileInteractor
    private let router: ProfileRouter
    private weak var view: ProfileView!
    private var profile: Profile?
    
    init(interactor: ProfileInteractor, router: ProfileRouter, view: ProfileView!) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension DefaultProfilePresenter: ProfilePresenter {
    var avatar: String {
        return profile?.avatar ?? ""
    }
    
    var email: String {
        return profile?.email ?? ""
    }
    
    var name: String {
        return profile?.name ?? ""
    }
    
    func loadProfile() {
        self.interactor.loadProfile { [weak self] (profile) in
            if let profile = profile {
                self?.profile = profile
                self?.view.showProfile()
            }else {
                self?.view.showLogin()
            }
        }
    }
    
    func presentLogin() {
        router.presentLogin {
            self.loadProfile()
        }
    }
}
