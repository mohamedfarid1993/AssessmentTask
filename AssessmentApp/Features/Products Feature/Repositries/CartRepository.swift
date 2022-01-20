//
//  CartRepository.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import UIKit
import CoreData

protocol Repository: FetchRepository {
    associatedtype T
    func update(product: T, completionHandler: @escaping ([T]?, Error?) -> Void)
    func delete(completionHandler: @escaping ([T]?, Error?) -> Void)
}

class CartRepository: Repository {
        
    typealias T = Product
        
    public static var shared = CartRepository()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingBasket")
        
    func get(completionHandler: @escaping ([Product]?, Error?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        fetchRequest.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else { return }
            var products: [Product] = []
            for item in result {
                products.append(item.toProduct())
            }
            completionHandler(products, nil)
        } catch {
            completionHandler(nil, error)
        }
    }
    
    func update(product: Product, completionHandler: @escaping ([Product]?, Error?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        product.toNSManagedObject()
        do {
            try context.save()
            self.get(completionHandler: completionHandler)
        } catch {
            completionHandler(nil, error)
        }
    }
    
    func delete(completionHandler: @escaping ([Product]?, Error?) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        guard let result = try? context.fetch(fetchRequest) as? [NSManagedObject] else { return }
        for object in result {
            context.delete(object)
        }
        do {
            try context.save()
            completionHandler([], nil)
        } catch {
            completionHandler(nil, error)
        }
    }
}
