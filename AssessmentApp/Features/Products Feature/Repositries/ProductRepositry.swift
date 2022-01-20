//
//  ProductRepositry.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation

struct ProductRepositry: Repositry {
    
    typealias T = [Product]
    
    func get(completionHandler: @escaping ([Product]?, Error?) -> Void) {
        ProductsRequest.getProducts.send(ProductResponse.self) { response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    var products: [Product] = []
                    result.values.forEach { value in
                        products.append(value)
                    }
                    completionHandler(products, nil)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
