//
//  CategoryListViewController.swift
//  E-Store
//
//  Created by Laptop MCO on 09/08/23.
//

import UIKit
import Kingfisher

protocol CategoryListView: AnyObject {
    func reloadData()
}

class CategoryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    
    
    var presenter: CategoryListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    // MARK: Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControl.beginRefreshing()
        presenter.loadCategoryList()
    }
    
    
    // MARK: - Helpers
    func setup(){
        title = "Category List"
        
        
        tableView.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: "CATEGORY_CELL")
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
        
    }
    
    @objc func refresh(_ sender: Any){
        presenter.loadCategoryList()
    }
    
}

// MARK: - CategoryListView
extension CategoryListViewController: CategoryListView {
    func reloadData() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CATEGORY_CELL", for: indexPath) as! CategoryViewCell
        cell.titleLabel.text = presenter.categoryName(at: indexPath.row)
        cell.thumbImageView.kf.setImage(with: URL(string: presenter.categoryImage(at: indexPath.row)))
        
        return cell
    }
}

extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectCategory(at: indexPath.row)
    }
}
