//
//  Product.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import CoreData

struct Product: CodableInit {
    
    let id: String
    let barcode: String
    let productDescription: String
    let imageURL: String
    let name: String
    let retailPrice: Int
    let costPrice: Int?

    enum CodingKeys: String, CodingKey {
        case barcode
        case productDescription = "description"
        case id
        case imageURL = "image_url"
        case name
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}

typealias ProductResponse = [String: Product]

extension Product {
    func toNSManagedObject() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingBasket", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(self.barcode, forKey: "barcode")
        object.setValue(self.id, forKey: "id")
        object.setValue(self.name, forKey: "name")
        object.setValue(self.imageURL, forKey: "image_url")
        object.setValue(self.productDescription, forKey: "product_description")
        object.setValue(self.retailPrice, forKey: "retail_price")
    }
}
