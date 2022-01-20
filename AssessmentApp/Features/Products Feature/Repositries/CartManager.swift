//
//  CartManager.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import CoreData

class CartManager {
    
    public static let shared = CartManager()
    
    private var cartRepository = CartRepository()
    
    func get(completionHandler: @escaping (Cart?, Error?) -> Void) {
        cartRepository.get { products, error in
            if let error = error {
                completionHandler(nil, error)
            } else {
                guard let products = products else { return }
                completionHandler(Cart(product: products, total: self.getTotal(products: products)), nil)
            }
        }
    }
    
    func update(product: Product, completionHandler: @escaping (Cart?, Error?) -> Void) {
        cartRepository.update(product: product) { products, error in
            if let error = error {
                completionHandler(nil, error)
            } else {
                guard let products = products else { return }
                completionHandler(Cart(product: products, total: self.getTotal(products: products)), nil)
            }
        }
    }
    
    func delete(completionHandler: @escaping (Cart?, Error?) -> Void) {
        cartRepository.delete { products, error in
            if let error = error {
                completionHandler(nil, error)
            } else {
                guard let products = products else { return }
                completionHandler(Cart(product: products, total: 0), nil)
            }
        }
    }
    
    func getTotal(products: [Product]) -> Int {
        var sum: Int = 0
        for product in products {
            sum += product.retailPrice
        }
        return sum
    }
}
