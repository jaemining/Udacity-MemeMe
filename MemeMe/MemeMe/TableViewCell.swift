//
//  TableViewCell.swift
//  MemeMe
//
//  Created by LimJaemin on 2017. 1. 28..
//  Copyright © 2017년 LimJaemin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var tableTopTextField: UITextField!
    @IBOutlet weak var tableBottomTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
