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

class LoginViewController: UIViewController, GIDSignInUIDelegate, AlertPresentable {
    
    @IBOutlet weak var signInBtn: GIDSignInButton!
    
    private var loginManager: GoogleLoginManager!
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
    
}


// MARK: - GoogleLoginManagerDelegate

extension LoginViewController: GoogleLoginManagerDelegate {
    func didFailToLogin(with error: Error) {
        showAlert(title: "Authentication Error", message: error.localizedDescription)
    }
    
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol) {
        self.authorizer = authorizer
        
        debug("Login Google success!!")
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerListVC") as? CustomerListViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

