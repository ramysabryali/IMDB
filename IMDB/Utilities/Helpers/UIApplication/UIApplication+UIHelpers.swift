//
//  UIApplication+UIHelpers.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import UIKit

extension UIApplication {
    var topController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        guard var topController = keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
    
    var window: UIWindow? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}

extension UIApplication {
    func showAlertView(
        _ alertData: AlertItem,
        completion: @escaping () -> Void
    ) {
        guard let topController = topController,
              !(topController is UIAlertController)
        else {
            return
        }
        
        let alert = UIAlertController(
            title: alertData.title,
            message: alertData.message,
            preferredStyle: alertData.style
        )
        for action in alertData.actions {
            alert.addAction(action.toUIAlertAction)
        }
        topController.present(alert, animated: true, completion: completion)
    }
}
