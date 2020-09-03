//
//  GoogleLoginManager.swift
//  JOJA
//
//  Created by Andrew on 2020/9/1.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

protocol GoogleLoginManagerDelegate: class {
    func didFailToLogin(with error: Error)
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol)
}

class GoogleLoginManager: NSObject, GIDSignInDelegate {
//    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheets]
    override init() {
        super.init()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    enum LoginErrors: Error {
        case failedToGetAuthorizer
        
        var localizedDescription: String {
            switch self {
            case .failedToGetAuthorizer:
                // NOTE: - Probably change to nslocalizedstring for lcalization purposes
                return "Failed to get authorizer"
            }
        }
    }
    
    weak var delegate: GoogleLoginManagerDelegate?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            delegate?.didFailToLogin(with: error)
        } else {
            if let authorizer = user.authentication.fetcherAuthorizer() {
                delegate?.didLoginSuccessfully(with: authorizer)
            } else {
                delegate?.didFailToLogin(with: LoginErrors.failedToGetAuthorizer)
            }
        }
    }
    
}
