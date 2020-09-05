//
//  CustomerListViewController.swift
//  JOJA
//
//  Created by Andrew on 2020/9/3.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class CustomerListViewController: UIViewController, AlertPresentable {

    @IBOutlet weak var output: UITextView!
    
    private var sheetsDataProvider: GoogleSheetsDataProvider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSheetsDataProvider()
        configView()
    }
    

    func configView() {
        output.isEditable = false
        output.text = "Getting sheet data..."
        
        sheetsDataProvider.listMajors(range: "B2:D50", { (models) in
            debug("get return data!!")
        })
    }
    
    
    private func configureSheetsDataProvider() {
        sheetsDataProvider = GoogleSheetsDataProvider()
        sheetsDataProvider.delegate = self
    }

}


// MARK: - SpreadSheetServiceDelegate

extension CustomerListViewController: SpreadSheetServiceDelegate {
    func didFailFetchingData(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func getString(with string: String) {
        output.text = string
    }
}


// MARK: - GoogleSheetsDataProviderDelegate

extension CustomerListViewController: GoogleSheetsDataProviderDelegate {
    
}
