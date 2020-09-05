//
//  Convertaboe.swift
//  Betway
//
//  Created by Wang Andrew on 2020/2/19.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol Convertable: Codable {

}

extension Convertable {

    func convertToDict() -> Dictionary<String, Any>? {

        var dict: Dictionary<String, Any>? = nil

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>

        } catch {
            print(error)
        }

        return dict
    }
}
