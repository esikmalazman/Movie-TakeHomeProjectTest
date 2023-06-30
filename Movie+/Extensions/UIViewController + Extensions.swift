//
//  UIViewController + Extensions.swift
//  Movie+
//
//  Created by Ikmal Azman on 30/06/2023.
//

import UIKit

extension UIViewController {
    func showErrorAlert(_ message : String?,
                        _ onRetryAction : @escaping () -> Void) -> UIAlertController {
        
        let alertController = UIAlertController(
            title: "Oops! Something went wrong!",
            message: message,
            preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            onRetryAction()
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(retryAction)
        alertController.addAction(okAction)
        
        return alertController
    }
}
