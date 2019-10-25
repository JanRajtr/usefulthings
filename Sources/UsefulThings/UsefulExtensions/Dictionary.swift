//
//  Dictionary.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation

public extension Dictionary
{
    
    /// Initialization of `Dictionary` with given `Array` of _Keys_ and `Array` of _Values_
    /// - parameters:
    ///   - keys: `Array<Key>`
    ///   - values: `Array<Values>`
    ///
    init(keys: [Key], values: [Value])
    {
        precondition(keys.count == values.count)
        
        self.init()
        
        for (index, key) in keys.enumerated()
        {
            self[key] = values[index]
        }
        
    }
    
    
}
