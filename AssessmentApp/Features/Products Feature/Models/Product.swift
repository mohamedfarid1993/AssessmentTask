//
//  Product.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import Foundation

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
