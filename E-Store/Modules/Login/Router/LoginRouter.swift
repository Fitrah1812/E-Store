//
//  LoginRouter.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import UIKit

protocol LoginRouter {
    func start(completion: @escaping () -> Void) -> UIViewController
    func finish()
}

final class DefaultLoginRouter {
    private var navigationController: UINavigationController!
    private var completion: () -> Void = { }
}

extension DefaultLoginRouter: LoginRouter {
    func finish() {
        navigationController.presentingViewController?.dismiss(animated: true, completion: self.completion)
    }
    
    func start(completion: @escaping () -> Void) -> UIViewController {
        self.completion = completion
        
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        let interactor = DefaultLoginInteractor()
        let presenter = DefaultLoginPresenter(interactor: interactor, router: self, view: viewController)
        viewController.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        
        return navigationController
    }
    
    
}

