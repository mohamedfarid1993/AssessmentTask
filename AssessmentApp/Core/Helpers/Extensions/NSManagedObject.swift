//
//  NSManagedObject.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import CoreData

extension NSManagedObject {
    func toProduct() -> Product {
        return Product(
            id: self.value(forKey: "id") as! String,
            barcode: self.value(forKey: "barcode") as! String,
            productDescription: self.value(forKey: "product_description") as! String,
            imageURL: self.value(forKey: "image_url") as! String,
            name: self.value(forKey: "name") as! String,
            retailPrice: self.value(forKey: "retail_price") as! Int,
            costPrice: nil)
    }
}
