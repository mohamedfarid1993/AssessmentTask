//
//  CodableInit.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import CoreMedia

protocol CodableInit: Codable {
    init(data: Data) throws
}

extension CodableInit {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

extension Array: CodableInit where Element: CodableInit {}
extension Dictionary: CodableInit where Key: CodableInit, Value: CodableInit {}
extension String: CodableInit {}
