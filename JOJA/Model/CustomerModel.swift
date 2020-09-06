//
//  CustomerModel.swift
//  JOJA
//
//  Created by Andrew on 2020/9/3.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation

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

extension CustomerModel {
    func getAmount() -> Int {
        let string = self.amount.replacingOccurrences(of: ",", with: "")
        guard let value = Int(string) else {
            return 0
        }
        return value
    }
}
