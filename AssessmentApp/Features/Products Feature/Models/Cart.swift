//
//  Cart.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import CoreData

struct Cart: CodableInit {
    
    var product: [Product]
    var total: Int
}
