//
//  MainController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit

#warning("""
The initial viewcontroller should show the shopping basket.
It should contain a 'Plus' button for adding new items to the basket.
It should contain a 'Clear' button for removing all items in the basket.
""")


class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProductTableViewCellDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var productsTableView: UITableView!
    
    // MARK: - IBActions
    
    // MARK: - Local Variables
    
    private var products: [Product] = [] {
        didSet {
            productsTableView.reloadData()
        }
    }
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProductsTableView()
        fetchProducts()
    }
    
    // MARK: - Setup View Methods
    
    private func setupProductsTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.rowHeight = 120
        let productCell = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productsTableView.register(productCell, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {
            cell.delegate = self
            cell.setupPrductCell(name: products[indexPath.row].name, price: products[indexPath.row].retailPrice, image: products[indexPath.row].imageURL)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Add Logic
    }
    
    // MARK: - Delegate Methods
    
    func addProduct() {
        // TODO: - Add Logic
    }
    
    // MARK: - Navigation Methods
    
    // MARK: - Networking Methods
    
    private func fetchProducts() {
        ProductsRequest.getProducts.send(ProductResponse.self) { [weak self] response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    var products: [Product] = []
                    result.values.forEach { value in
                        products.append(value)
                    }
                    self?.products = products
                }
            case .failure(let error):
                self?.showRetryAlert(with: error.localizedDescription, title: "Error", handler: { alert in
                    self?.fetchProducts()
                })
            }
        }
    }
}
