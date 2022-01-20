//
//  DetailController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import CoreData

class DetailController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    // MARK: - Local Variables
    
    var product: Product?
    var shoppingItem: NSManagedObject?
    
    // MARK: - View Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        self.title = "Product"
        if let product = product  {
            productImageView.kf.setImage(with: URL(string: product.imageURL))
            priceLabel.text = "\(product.retailPrice)$"
            descriptionLabel.text = product.productDescription
            nameLabel.text = product.name
        } else if let shoppingItem = shoppingItem {
            productImageView.kf.setImage(with: URL(string: shoppingItem.value(forKey: "image_url") as! String))
            priceLabel.text = "\(shoppingItem.value(forKey: "retail_price") as! Int)$"
            descriptionLabel.text = shoppingItem.value(forKey: "product_description") as? String
            nameLabel.text = shoppingItem.value(forKey: "name") as? String
        }
    }
}
