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
    }
    
}
