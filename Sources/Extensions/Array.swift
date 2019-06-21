//
//  Array.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation

extension Array where Element : Hashable {
    mutating func removeDuplicates() {
        
        self = Array(Set(self))
        
        
        
    }
}


