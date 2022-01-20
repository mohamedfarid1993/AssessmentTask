//
//  APIRequestHandler.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import Alamofire

/// Response completion handler beautified.
typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?

/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamofireResponse {
    
}

extension APIRequestHandler where Self: URLRequestBuilder {
    
    func send<T: CodableInit>(_ decoder: T.Type, completion: CallResponse<T>) {
        if NetworkReachabilityManager()?.isReachable ?? false {
            NetworkManager.manager.request(self).responseData { response in
                self.handleResponse(response, completion: completion)
            }
        } else {
            completion?(ServerResponse.failure(ResponseError.offline))
        }
    }
}
