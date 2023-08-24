//
//  FavoriteListViewController.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import UIKit

protocol FavoriteListView: AnyObject {
    func reloadData()
    
}

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoriteListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        presenter.loadFavoriteList()
    }

    func setup(){
        title = "Favorite List"
        tableView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: "PRODUCT_CELL")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FavoriteListViewController: FavoriteListView {
    
    
    func reloadData() {
        if isViewLoaded {
            tableView.reloadData()
        }
    }
    
}

extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFavorites()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PRODUCT_CELL", for: indexPath) as! ProductViewCell
        
        cell.nameLabel.text = presenter.productTitle(at: indexPath.row)
        cell.descriptionLabel.text = presenter.productDescription(at: indexPath.row)
        cell.priceLabel.text = presenter.productPrice(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view,
            completion in
            self.presenter.deleteFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        if #available(iOS 13.0, *) {
            action.image = UIImage(systemName: "trash")
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}


