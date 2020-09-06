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

    @IBOutlet private weak var tableview: UITableView!
    
    private var sheetsDataProvider: GoogleSheetsDataProvider!
    
//    var customerDatas = Observable.just([CustomerModel]())
    var customerDatas: PublishSubject<[CustomerModel]> = PublishSubject()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSheetsDataProvider()
        configureTableView()
        getSheetData()
    }
    
    // get sheet data
    private func getSheetData() {
        sheetsDataProvider.listMajors(range: "B2:D", { (models) in
            debug("get return data!!")
            self.customerDatas.onNext(models)
        })
    }
    
    
    private func configureSheetsDataProvider() {
        sheetsDataProvider = GoogleSheetsDataProvider()
        sheetsDataProvider.delegate = self
    }

    private func configureTableView() {
        tableview.register(UINib(nibName: "\(CustomerCell.self)", bundle: nil), forCellReuseIdentifier: CustomerCell.Identifier)
        
        setupCellConfiguration()
        setupCellTapHandling()
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
    
    func setupCellTapHandling() {
        tableview
            .rx
            .modelSelected(CustomerModel.self)
            .subscribe(onNext: { (cell) in
                // TODO: do some action here
                debug(cell.name)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    }
}


