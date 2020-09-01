//
//  ViewController.swift
//  JOJA
//
//  Created by Andrew on 2020/8/29.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    
    @IBOutlet weak var signInBtn: GIDSignInButton!
    
    private var loginManager: GoogleLoginManager!
    private var sheetService = SpreadSheetService()
    private var authorizer: GTMFetcherAuthorizationProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        configureLoginManager()
    }
    
    private func configureLoginManager() {
        self.loginManager = GoogleLoginManager()
        loginManager.delegate = self
    }
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - GoogleLoginManagerDelegate

extension LoginViewController: GoogleLoginManagerDelegate {
    func didFailToLogin(with error: Error) {
        showAlert(title: "Authentication Error", message: error.localizedDescription)
    }
    
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol) {
        self.signInBtn.isHidden = true
        self.authorizer = authorizer
    }
}
