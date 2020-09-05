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
import RxSwift
import RxCocoa

class CustomerListViewController: UIViewController, AlertPresentable {

//    @IBOutlet weak var output: UITextView!
    @IBOutlet private weak var tableview: UITableView!
    
    private var sheetsDataProvider: GoogleSheetsDataProvider!
    
//    var customerDatas = Observable.just([CustomerModel]())
    var customerDatas: PublishSubject<[CustomerModel]> = PublishSubject()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "\(CustomerCell.self)", bundle: nil), forCellReuseIdentifier: CustomerCell.Identifier)
        
        configureSheetsDataProvider()
        setupCellConfiguration()
        configView()
    }
    

    func configView() {
        sheetsDataProvider.listMajors(range: "B2:D50", { (models) in
            debug("get return data!!")
//            self.customerDatas = Observable.from(optional: models)
            self.customerDatas.onNext(models)
        })
    }
    
    
    private func configureSheetsDataProvider() {
        sheetsDataProvider = GoogleSheetsDataProvider()
        sheetsDataProvider.delegate = self
    }

}


// MARK: - GoogleSheetsDataProviderDelegate

extension CustomerListViewController: GoogleSheetsDataProviderDelegate {
    func didFailFetchingData(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}


// MARK: - Rx Setup

extension CustomerListViewController {
    func setupCellConfiguration() {
        customerDatas
            .bind(to: tableview
                .rx
                .items(cellIdentifier: CustomerCell.Identifier,
                       cellType: CustomerCell.self)) { row, customer, cell in
                        cell.configureWithModel(model: customer)
        }
        .disposed(by: disposeBag)
    }
}


