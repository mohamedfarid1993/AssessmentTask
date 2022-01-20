//
//  ShoppingBasketButton.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import UIKit

class ShoppingBasketButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        self.setImage(UIImage(systemName: "arrow.up.circle"), for: .selected)
    }
}
