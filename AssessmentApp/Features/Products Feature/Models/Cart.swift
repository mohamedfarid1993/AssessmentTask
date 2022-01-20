//
//  Cart.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import CoreData

class Cart {
    
    public static var shared = Cart()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingBasket")
        
    var products: [NSManagedObject] = [] {
        didSet {
            var sum = 0
            for product in products {
                sum += product.value(forKey: "retail_price") as! Int
            }
            total = sum
        }
    }
    
    var total = 0

    func addItem(product: Product) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingBasket", in: context)
        let newProduct = NSManagedObject(entity: entity!, insertInto: context)
        newProduct.setValue(product.barcode, forKey: "barcode")
        newProduct.setValue(product.id, forKey: "id")
        newProduct.setValue(product.name, forKey: "name")
        newProduct.setValue(product.imageURL, forKey: "image_url")
        newProduct.setValue(product.productDescription, forKey: "product_description")
        newProduct.setValue(product.retailPrice, forKey: "retail_price")
        do {
           try context.save()
            products.append(newProduct)
          } catch {
              fatalError("Saving Failed")
          }
    }
    
    func fetchItems() -> [NSManagedObject] {
        let context = appDelegate.persistentContainer.viewContext
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest) as? [NSManagedObject]
            products = result ?? []
            return products
        } catch {
            fatalError("Fetching Failed")
        }
    }
    
    func emptyCart() {
        let context = appDelegate.persistentContainer.viewContext
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object as! NSManagedObject)
            }
            products = []
        }
    }
}
