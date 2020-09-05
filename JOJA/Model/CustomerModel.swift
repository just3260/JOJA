//
//  CustomerModel.swift
//  JOJA
//
//  Created by Andrew on 2020/9/3.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

//class CustomerModel: Codable {
//

//
//    private var input = [[String]]()
//    private(set) var workerMeal = [String]()
//
//    init(with data: [[String]]) {
//        self.input = data
//        formDailyMenu()
//    }
//
//    private func formDailyMenu() {
//        input.removeFirst() // removing unnecessary fields
//        let menu = input.removeFirst() // geting menu items
//
//        for workerRequests in input {
//            for item in 1..<workerRequests.count {
//                if !workerRequests[item].isEmpty {
//                    workerMeal.append(menu[item])
//                }
//            }
//        }
//    }
//
//}


struct CustomerModel: Codable {
    let name: String
    let date: String
    let amount: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case date = "date"
        case amount = "amount"
    }
}
