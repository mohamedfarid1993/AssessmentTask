//
//  UIVIewController.swift
//  AssessmentApp
//
//  Created by Mohamed Farid on 20/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showRetryAlert(with message: String, title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: handler))
        present(alertController, animated: true, completion: nil)
    }
}
