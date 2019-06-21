//
//  Array.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation

infix operator ====:ComparisonPrecedence

public extension Array where Element: Comparable {
    
    /// Sorts the array. The affects the order of the array.
    public mutating func sort() {
        self = self.sorted()
    }
}


public extension Array where Element : Hashable {
    
    /// Removes the duplicates from the array. The function is mutating and affects the order of the array.
    public mutating func removeDuplicates() {
        self = Array(Set(self))
    }
    
    
    /// Removes the duplicates from the array. The function affects the order of the array.
    public func duploMap() -> Array<Element> {
        return Array(Set(self))
    }
    
    /// Non-duplicates from the array. The function affects the order of the array.
    public var nonDuplicates:Array<Element> {
        return Array(Set(self))
    }
    
    
    public static func ====(left:Array<Element>, right:Array<Element>) -> Bool {
        
        let set1 = Set(arrayLiteral: left)
        let set2 = Set(arrayLiteral: right)
        
        let diff = set1.symmetricDifference(set2)
        
        guard diff.count == 0 else {
            return false
        }
        
        return true
        
        
    }
    
    
}


