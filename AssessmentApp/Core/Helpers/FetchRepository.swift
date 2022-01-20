//
//  FetchRepository.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation

protocol FetchRepository {
    associatedtype T
    func get(completionHandler: @escaping ([T]?, Error?) -> Void)
}
