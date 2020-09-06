//
//  CustomerCell.swift
//  JOJA
//
//  Created by Andrew on 2020/9/6.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {
    static let Identifier = "CustomerCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithModel(model: CustomerModel) {
        nameLabel.text = model.name
        amountLabel.text = model.amount
        
        
        
        backgroundColor = model.getAmount() > 10000 ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
}
