//
//  ProductTableViewCell.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import UIKit
import Kingfisher

protocol ProductTableViewCellDelegate: AnyObject {
    func addProduct()
}

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func addPressed(_ sender: Any) {
        delegate?.addProduct()
    }
    
    // MARK: - Local Variables
    
    weak var delegate: ProductTableViewCellDelegate?
    
    // MARK: - View Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    // MARK: - Setup View Methods
    
    func setupPrductCell(name: String, price: Int, image: String) {
        nameLabel.text = name
        priceLabel.text = "\(price)$"
        productImage.kf.setImage(with: URL(string: image))
    }
}
