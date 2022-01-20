//
//  ProductsRequest.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import Alamofire

enum ProductsRequest: URLRequestBuilder {
    
    case getProducts

    internal var path: String {
        switch self {
        case .getProducts:
            return "/4e23865c-b464-4259-83a3-061aaee400ba"
        }
    }
    
    internal var paramaters: Parameters? {
        switch self {
        case .getProducts:
            return nil
        }
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
}
