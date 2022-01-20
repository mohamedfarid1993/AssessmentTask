//
//  ServerResponse.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation

enum ServerResponse<T> {
    case success(T), failure(LocalizedError)
}
