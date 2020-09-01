//
//  GoogleSheetsDataProvider.swift
//  JOJA
//
//  Created by Andrew on 2020/9/1.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

protocol GoogleSheetsDataProviderDelegate: class {
    func didFailFetchingData(with error: Error)
}

class GoogleSheetsDataProvider: NSObject {
    
    private let spreadsheetId = "1NrPDjp80_7venKB0OsIqZLrq47jbx9c-lrWILYJPS88"
    
    private let service = GTLRSheetsService()
    
    weak var delegate: GoogleSheetsDataProviderDelegate?
    
//    private var listLoadingCompletionHandler: ((DailyMenuModel) -> ())?
    
    enum GoogleSheetsDataProviderErrors: Error {
        case invalidData
        case noData
        
        var localizedDescription: String {
            switch self {
            case .invalidData:
                return "Fetched data is corrupted"
            case .noData:
                return "Fetched data is missing"
            }
        }
    }
    
    init(_ authorizer: GTMFetcherAuthorizationProtocol) {
        super.init()
        self.service.authorizer = authorizer
    }
    
    func updateServiceAuthorizer(to authorizer: GTMFetcherAuthorizationProtocol) {
        
    }
    
    
//    func listMajors(_ completionHandler: @escaping ((DailyMenuModel) -> ()), range: String){
//        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
//            .query(withSpreadsheetId: spreadsheetId, range: range)
//        self.listLoadingCompletionHandler = completionHandler
//        service.executeQuery(query,
//                             delegate: self,
//                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
//
//        )
//    }
    
    @objc private func displayResultWithTicket(ticket: GTLRServiceTicket,
                                               finishedWithObject result : GTLRSheets_ValueRange,
                                               error : NSError?) {
        
        if let error = error {
            delegate?.didFailFetchingData(with: error)
            return
        }
        guard let data = result.values as? [[String]] else {
            delegate?.didFailFetchingData(with: GoogleSheetsDataProviderErrors.invalidData)
            return
        }
        guard data.isEmpty == false else {
            delegate?.didFailFetchingData(with: GoogleSheetsDataProviderErrors.noData)
            return
        }
        
//        let model = DailyMenuModel(with: data)
        
//        listLoadingCompletionHandler?(model)
    }
    
}

