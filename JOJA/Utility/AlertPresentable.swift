//
//  AlertPresentable.swift
//  JOJA
//
//  Created by Andrew on 2020/9/3.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import UIKit


//struct AlertActionComponent {
//    var title: String
//    var style: UIAlertAction.Style
//    var handler: ((UIAlertAction) -> Void)?
//
//    init(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)?) {
//        self.title = title
//        self.style = style
//        self.handler = handler
//    }
//}
//
//struct AlertComponents {
//    var title: String?
//    var message: String?
//    var actions: [UIAlertAction]
//    var completion: (() -> Void)?
//
//    init(title: String?, message: String? = nil, actions: [AlertActionComponent], completion: (() -> Void)? = nil) {
//        self.title = title
//        self.message = message
//        self.completion = completion
//        self.actions = actions.map {
//            UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler)
//        }
//    }
//}

protocol AlertPresentable where Self: UIViewController {
//    var alertStyle: UIAlertController.Style { get }
//    var alertComponents: AlertComponents { get }
}

extension AlertPresentable {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
//    private var alertTitle: String? {
//        return alertComponents.title
//    }
//
//    private var message: String? {
//        return alertComponents.message
//    }
//
//    private var actions: [UIAlertAction] {
//        return alertComponents.actions
//    }
//
//    var alertStyle: UIAlertController.Style {
//        return .alert
//    }
//
//    private var completion: (() -> Void)? {
//        return alertComponents.completion
//    }
//
//    func presentAlert() {
//        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: alertStyle)
//        actions.forEach { alert.addAction($0) }
//
//        present(alert, animated: true, completion: completion)
//    }
//
//    func showAlert(title : String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
//        actions.forEach { alert.addAction($0) }
//
//        present(alert, animated: true, completion: completion)
//    }
}



//// MARK: - AlertPresentable Protocol
//
//extension LoginViewController: AlertPresentable {
//    var alertComponents: AlertComponents {
//        let action = AlertActionComponent(title: "OK", handler: nil)
//        let alertComponents = AlertComponents(title: "Alert", message: "Not a simple one, is a POP one.", actions: [action], completion: {
//            print("Just presented")
//        })
//        return alertComponents
//    }
//}
