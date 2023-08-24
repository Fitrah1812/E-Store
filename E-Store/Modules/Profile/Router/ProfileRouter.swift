//
//  PresenterRouter.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import UIKit

protocol ProfileRouter {
    func start() -> UIViewController
    func presentLogin(completion: @escaping () -> Void)
}

final class DefaultProfileRouter {
    private var navigationController: UINavigationController!
}

extension DefaultProfileRouter: ProfileRouter {
    func start() -> UIViewController {
        let viewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        let interactor = DefaultProfileInteractor(profileRepository: ProfileRepository(apiService: ApiService()))
        let presenter = DefaultProfilePresenter(interactor: interactor, router: self, view: viewController)
        viewController.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        
        return navigationController
    }
    
    func presentLogin(completion: @escaping () -> Void) {
        let viewController = DefaultLoginRouter().start(completion: completion)
        navigationController.present(viewController, animated: true)
    }
    
}
