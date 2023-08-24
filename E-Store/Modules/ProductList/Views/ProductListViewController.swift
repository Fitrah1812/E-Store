//
//  ProductListViewController.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import UIKit

protocol ProductListView: AnyObject {
    func reloadData()
    func deleteProduct(at index: Int)
}

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    
    var presenter: ProductListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getCoreDataDBPath()
    }
    
    // MARK: Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControl.beginRefreshing()
        presenter.loadCategoryByProductList()
    }
    
    func getCoreDataDBPath() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding

         print("Core Data DB Path :: \(path ?? "Not found")")
    }

    func setup() {
        title = presenter.categoryName()

        tableView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: "PRODUCT_CELL")
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: Any){
        presenter.loadCategoryByProductList()
    }
}

// MARK: - CategoryListView
extension ProductListViewController: ProductListView {
    func deleteProduct(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: .middle)
    }
    
    func reloadData() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PRODUCT_CELL", for: indexPath) as! ProductViewCell
        
        
        cell.nameLabel.text = presenter.productTitle(at: indexPath.row)
        cell.descriptionLabel.text = presenter.productDescription(at: indexPath.row)
        cell.priceLabel.text = presenter.productPrice(at: indexPath.row)
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favorite") { action, view,
            completion in
            self.presenter.saveFavorite(at: indexPath.row)
            
            completion(false)
        }
        if #available(iOS 13.0, *) {
            action.image = UIImage(systemName: "star")
        } else {
            // Fallback on earlier versions
        }
        return UISwipeActionsConfiguration(actions: [action])

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view,
            completion in
            self.presenter.deleteProduct(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
    
        
        if #available(iOS 13.0, *) {
            action.image = UIImage(systemName: "trash")
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
