//
//  HandleAlamofireResponse.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import Alamofire

protocol HandleAlamofireResponse {
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>)
}

extension HandleAlamofireResponse where Self: URLRequestBuilder {
    
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>) {
                
        switch response.result {
        case .failure(let error):
            completion?(ServerResponse.failure(ResponseError.network(message: error.localizedDescription)))
        case .success(let value):
            handleSuccessResponse(value, response: response, completion: completion)
        }
    }
    
    func handleSuccessResponse<T: CodableInit>(
        _ value: Data,
        response: DataResponse<Data>? = nil,
        completion: CallResponse<T>) {
        do {
            let responseData = try T(data: value)
            if response?.response?.statusCode == 200 {
                completion?(ServerResponse<T>.success(responseData))
            } else {
                completion?(ServerResponse.failure(ResponseError.unknown))
            }
        } catch {
            completion?(ServerResponse.failure(ResponseError.decoding))
        }
    }
}
