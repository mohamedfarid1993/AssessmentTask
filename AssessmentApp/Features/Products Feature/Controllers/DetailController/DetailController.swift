//
//  DetailController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit

class DetailController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    // MARK: - Local Variables
    
    var product: Product?
    
    // MARK: - View Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        guard let product = product else { return }
        productImageView.kf.setImage(with: URL(string: product.imageURL))
        self.title = "Product"
        priceLabel.text = "\(product.retailPrice)$"
        descriptionLabel.text = product.productDescription
        nameLabel.text = product.name
    }
}
