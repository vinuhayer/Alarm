//
//  UITableViewExtension.swift
//  Alarm
//
//  Created by Appinventiv on 12/04/20.
//  Copyright © 2020 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    ///Register Table View Cell Nib
    func registerCell(with identifier: UITableViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellReuseIdentifier: "\(identifier.self)")
    }
    
    ///Register Header Footer View Nib
    func registerHeaderFooter(with identifier: UITableViewHeaderFooterView.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil), forHeaderFooterViewReuseIdentifier: "\(identifier.self)")
    }
    
    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath? = nil) -> T {
        if let index = indexPath {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: index) as! T
        } else {
            return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
        }
    }
    
    ///Dequeue Header Footer View
    func dequeueHeaderFooter <T: UITableViewHeaderFooterView> (with identifier: T.Type) -> T {
        print("\(identifier.self)")
        return self.dequeueReusableHeaderFooterView(withIdentifier: "\(identifier.self)") as! T
    }
}
