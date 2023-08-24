//
//  MainViewController.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit



protocol MainView: AnyObject {
    
}

class MainViewController: UITabBarController {

    var presenter: MainPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.favoriteAdded(_:)), name: .favoriteAdded, object: nil)
    }
    
    @objc func favoriteAdded(_ sender: Any) {
        viewControllers?[1].tabBarItem.badgeValue = "!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in 0..<(viewControllers?.count ?? 0) {
            let viewController = viewControllers?[i]
            switch i {
            case 0:
                viewController?.tabBarItem.title = "Home"
                if #available(iOS 13.0, *) {
                    viewController?.tabBarItem.image = UIImage(systemName: "house")
                    viewController?.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
                }
            case 1:
                viewController?.tabBarItem.title = "Favorites"
                if #available(iOS 13.0, *) {
                    viewController?.tabBarItem.image = UIImage(systemName: "star")
                    viewController?.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
                }
            case 2:
                viewController?.tabBarItem.title = "Profile"
                if #available(iOS 13.0, *) {
                    viewController?.tabBarItem.image = UIImage(systemName: "person")
                    viewController?.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
                }
            default:
                break
            }
        }
    }

}

extension MainViewController: MainView {
    
}

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        item.badgeValue = nil
    }
}
