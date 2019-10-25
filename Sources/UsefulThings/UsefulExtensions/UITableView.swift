//
//  UITableViewExtension.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func reloadRows(inSection:Int) {
        
        let numberOfRows = self.numberOfRows(inSection: inSection)
        
        for row in 0..<numberOfRows {
            let indexPath = IndexPath(row: row, section: inSection)
            self.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
    }
}
