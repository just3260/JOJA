//
//  SpreadSheetManager.swift
//  JOJA
//
//  Created by Andrew on 2020/9/1.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST


class SpreadSheetService {
    
    // for test
//    private let spreadsheetId = "1y3e_hKM7nDjDudZFU9ciUdSY3zdVe9-jGC7bzkZ8qlc"
    private let spreadsheetId = "1dJs3rjIdYwpWbwT5ekmFRK7tPbEXrFLHW-ag2XILpiE"
    
    private let service = GTLRSheetsService()
    private var authorizer: GTMFetcherAuthorizationProtocol!
    
    var arrValues = [[Any]]()
    
    
    
    func setDatas() {
        self.arrValues = [["TRUE", "FALSE", "TRUE", "FALSE","FALSE"], ["TRUE", "FALSE", "TRUE", "FALSE","FALSE"], ["TRUE", "FALSE", "TRUE", "FALSE","FALSE"], ["TRUE", "FALSE", "TRUE", "FALSE","FALSE"], ["TRUE", "FALSE", "TRUE", "FALSE","FALSE"],["TRUE", "FALSE", "TRUE", "FALSE","FALSE"],["TRUE", "FALSE", "TRUE", "FALSE","FALSE"]]
    }
    
    
    // Display (in the UITextView) the names and majors of students in a sample
    // spreadsheet:
    // https://docs.google.com/spreadsheets/d/1WHzRVc7wIhoN7NbjVDnY7atEeYg7OiY1amfPTZnM5O8/edit
    func listMajors() {
        //        service.apiKey = "AIzaSyBg42iUHcRKKkLRhlRv5HUq1_p3Lv7aVPs"
        print("Getting sheet data...")
        
        let range = "A1:J8"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range)
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var majorsString = ""
        let rows = result.values!
        
        if rows.isEmpty {
            print("No data found.")
            return
        }
        
        majorsString += "Name, Major:\n"
        for row in rows {
            let name = row[0]
            var value = ""
            if row.count > 1 {
                value = row[1] as! String
            } else {
                value = ""
            }
            
            majorsString += "\(name), \(value)\n"
        }
        
        print(majorsString)
    }
    
    @objc func dummy(ticket: GTLRServiceTicket, finishedWithObject result : GTLRSheets_ValueRange, error : NSError?) {
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        print("OK")
    }
    
    @objc func writeValues() {
        let range = "B2:F8"
        let valueRange = GTLRSheets_ValueRange.init()
        valueRange.values = self.arrValues
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.query(withObject: valueRange, spreadsheetId: spreadsheetId, range: range)
        query.valueInputOption = "USER_ENTERED"
        service.executeQuery(query, delegate: self, didFinish: #selector(self.dummy(ticket:finishedWithObject:error:)))
        
        //            .query(withSpreadsheetId: spreadsheetId, range:range)
        //        service.executeQuery(query,
        //                             delegate: self,
        //                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
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
        alert.show()
    }
    
}




