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
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var shoppingBasketButton: ShoppingBasketButton!
    @IBOutlet weak var shoppingBasketTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shoppingBasketTableView: UITableView!
    @IBOutlet weak var productsTableViewheightconstraint: NSLayoutConstraint!
    @IBOutlet weak var productsTableView: UITableView!
    
    // MARK: - IBActions
    
    @IBAction func shoppingBasketButtonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            button.isSelected = !button.isSelected
            animateShoppingBasketList(shouldShow: button.isSelected)
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
    }
    
    // MARK: - Local Variables
    
    private var products: [Product] = [] {
        didSet {
            productsTableView.reloadData()
            productsTableViewheightconstraint.constant = productsTableView.contentSize.height
            shoppingBasketTableView.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    
    private let repositry = ProductRepositry()
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        setupProductsTableView()
        fetchProducts()
        setupShoppingBasketTableView()
    }
    
    // MARK: - Setup View Methods
    
    private func setupShoppingBasketTableView() {
        shoppingBasketTableView.delegate = self
        shoppingBasketTableView.dataSource = self
        shoppingBasketTableView.rowHeight = 120
        let productCell = UINib(nibName: "ProductTableViewCell", bundle: nil)
        shoppingBasketTableView.register(productCell, forCellReuseIdentifier: "ProductTableViewCell")
        shoppingBasketTableViewHeightConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    private func setupProductsTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.rowHeight = 120
        let productCell = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productsTableView.register(productCell, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func animateShoppingBasketList(shouldShow: Bool) {
        shoppingBasketTableViewHeightConstraint.constant = shouldShow ? self.shoppingBasketTableView.contentSize.height : 0
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {
            cell.delegate = self
            cell.setupPrductCell(name: products[indexPath.row].name, price: products[indexPath.row].retailPrice, image: products[indexPath.row].imageURL)
            switch tableView {
            case productsTableView:
                cell.addButton.isHidden = false
            case shoppingBasketTableView:
                cell.addButton.isHidden = true
            default:
                break
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToDetails", sender: products[indexPath.row])
    }
    
    // MARK: - Delegate Methods
    
    func addProduct() {
        // TODO: - Add Logic
    }
    
    // MARK: - Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetails" {
            if let product = sender as? Product, let detailsVC = segue.destination as? DetailController {
                detailsVC.product = product
            }
        }
    }
    
    // MARK: - Networking Methods
    
    private func fetchProducts() {
        repositry.get { [weak self] products, error in
            if let error = error {
                self?.showRetryAlert(with: error.localizedDescription, title: "Error", handler: { alert in
                    self?.fetchProducts()
                })
            } else {
                self?.products = products ?? []
            }
        }
    }
}
