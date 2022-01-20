//
//  MainController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import CoreData

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
        emptyCart()
    }
    
    // MARK: - Local Variables
    
    private var products: [Product] = [] {
        didSet {
            productsTableView.reloadData()
            productsTableViewheightconstraint.constant = productsTableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    private var shoppingList: [Product] = [] {
        didSet {
            shoppingBasketTableView.reloadData()
            if shoppingBasketTableViewHeightConstraint.constant != 0 {
                shoppingBasketTableViewHeightConstraint.constant = shoppingBasketTableView.contentSize.height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private var cart: Cart? {
        didSet {
            guard let cart = cart else { return }
            shoppingList = cart.product
            totalLabel.text = "Total \(cart.total)$"
        }
    }
    
    private let repository = ProductRepository()
    
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
        getCart()
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
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func getCart() {
        CartManager.shared.get { [weak self] cart, error in
            if let error = error {
                self?.showRetryAlert(with: error.localizedDescription, title: "Error", handler: { alert in
                    self?.getCart()
                })
            } else {
                self?.cart = cart
            }
        }
    }
    
    private func emptyCart() {
        CartManager.shared.delete { [weak self] cart, error in
            if let error = error {
                self?.showRetryAlert(with: error.localizedDescription, title: "Error", handler: { alert in
                    self?.emptyCart()
                })
            } else {
                self?.cart = cart
            }
        }
    }
    
    private func updateCart(indexPath: IndexPath) {
        CartManager.shared.update(product: products[indexPath.row]) { [weak self] cart, error in
            if let error = error {
                self?.showRetryAlert(with: error.localizedDescription, title: "Error", handler: { alert in
                    self?.addProduct(indexPath: indexPath)
                })
            } else {
                self?.cart = cart
            }
        }
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case productsTableView:
            return products.count
        case shoppingBasketTableView:
            return shoppingList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell {
            cell.delegate = self
            switch tableView {
            case productsTableView:
                cell.setupProductCell(
                    name: products[indexPath.row].name,
                    price: products[indexPath.row].retailPrice,
                    image: products[indexPath.row].imageURL,
                    indexPath: indexPath)
                cell.addButton.isHidden = false
            case shoppingBasketTableView:
                cell.setupProductCell(
                    name: shoppingList[indexPath.row].name,
                    price: shoppingList[indexPath.row].retailPrice,
                    image: shoppingList[indexPath.row].imageURL,
                    indexPath: indexPath)
                cell.addButton.isHidden = true
            default:
                break
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case productsTableView:
            self.performSegue(withIdentifier: "GoToDetails", sender: products[indexPath.row])
        case shoppingBasketTableView:
            self.performSegue(withIdentifier: "GoToDetails", sender: shoppingList[indexPath.row])
        default:
            break
        }
    }
    
    // MARK: - Delegate Methods
    
    func addProduct(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        updateCart(indexPath: indexPath)
    }
    
    // MARK: - Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetails" {
            if let detailsVC = segue.destination as? DetailController {
                if let product = sender as? Product {
                    detailsVC.product = product
                }
            }
        }
    }
    
    // MARK: - Networking Methods
    
    private func fetchProducts() {
        repository.get { [weak self] products, error in
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
