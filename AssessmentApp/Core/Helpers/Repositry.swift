//
//  Repositry.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation

protocol Repositry {
    associatedtype T
    func get(completionHandler: @escaping (T?, Error?) -> Void)
}
