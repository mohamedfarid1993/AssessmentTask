//
//  URLRequestBuilder.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible, APIRequestHandler {
    var paramaters: Parameters? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var url: URL { get }
    var urlRequest: URLRequest { get }
    var encoding: ParameterEncoding { get }
    var APIVersion: String { get }
    var mainURL: String { get }
}

extension URLRequestBuilder {
    
    var APIVersion: String {
        return Constants.KATMockServerURLVersionNumber
    }
    
    var mainURL: String {
        return "\(Constants.KATMockServerURL)\(APIVersion)"
    }
    
    var url: URL {
        var url = URL(string: mainURL)!
        url.appendPathComponent(path)
        return url
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        return urlRequest
    }
    
    var headers: HTTPHeaders {
        return SessionManager.defaultHTTPHeaders
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: paramaters)
    }
}
