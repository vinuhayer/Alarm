//
//  AlarmTableCell.swift
//  Alarm
//
//  Created by Appinventiv on 12/04/20.
//  Copyright © 2020 Appinventiv. All rights reserved.
//

import UIKit

class AlarmTableCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK:- Functions
    func populate(model: AlarmModel) {
        lblTitle.text = model.subject
        lblTime.text = "\(model.date ?? "") \(model.time ?? "")"
    }
}
