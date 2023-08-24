//
//  MainPresenter.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import Foundation

protocol MainPresenter {
    
}

final class DefaultMainPresenter {
    private let interactor: MainInteractor
    private let router: MainRouter
    private weak var view: MainView?
    
    init(interactor: MainInteractor, router: MainRouter, view: MainView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension DefaultMainPresenter: MainPresenter {
    
}
