//
//  UIViewController + Extensions.swift
//  Movie+
//
//  Created by Ikmal Azman on 30/06/2023.
//

import UIKit

extension UIViewController {
    func showAlert(_ title : String?,
                   _ message : String?,
                   _ actions : [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        return alertController
    }
}
