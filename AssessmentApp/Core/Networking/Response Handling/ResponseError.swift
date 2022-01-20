//
//  ResponseError.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation

enum ResponseError: LocalizedError {
    case decoding
    case offline
    case unknown
    case network(message: String)

    var errorDescription: String? {
        switch self {
        case .decoding:
            return "Sorry, unexpected error occured. Will fix this so soon"
        case .offline:
            return "Please connect to the internet"
        case .unknown:
            return "Sorry, unnkown error occured. Please try again in a while"
        case .network(let message):
            return message
        }
    }
}
