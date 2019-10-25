//
//  NSDateExtension.swift
//  Constructo
//
//  Created by Jan Rajtr on 15.08.17.
//  Copyright © 2017 Jan Rajtr. All rights reserved.
//

import Foundation

/// Implements MySQL string value of given `NSDate`.
extension NSDate {
    
    /// Returns `String` representation of given `NSDate` class in MySQL format
    /// - returns:
    ///     `String` value in "yyyy-MM-dd'T'HH:mm:ss.SSSZ" format
    func toSQLString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//.SSSZ"
        return dateFormatter.string(from: self as Date)
    }
    
    
    
    
    /// Returns `NSDate` object from given string in MySQL format
    /// - parameters:
    ///     - date:`String`   -   value of `NSDate`, usually received via REST from server
    /// - returns:
    ///     Given date as `NSDate` object.
    func fromSQLString(date:String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//.SSSZ"
        
        let dateString = date
        if let datePublished = dateFormatter.date(from: dateString) {
            return datePublished as NSDate
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            if let datePublished = dateFormatter.date(from: dateString) {
                return datePublished as NSDate
            }
            return NSDate()
        }
    }
    
    func toReadableString(gmt:Bool) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        
        if gmt {
            let date = self.accordingToGMT()
            return dateFormatter.string(from: date as Date)
        } else {
            return dateFormatter.string(from: self as Date)
        }
    }
    
    func fromReadableString(date:String) -> NSDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        
        let dateString = date
        if let datePublished = dateFormatter.date(from: dateString) {
            return datePublished as NSDate
        } else {
            return NSDate()
        }
    }
    
    func GMT() -> NSDate {
        
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT() }
        let hours = (secondsFromGMT/3600) * (-1)
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .hour, value: hours, to: self as Date)
        return date! as NSDate
    }
    
    func accordingToGMT() -> NSDate {
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT() }
        let hours = secondsFromGMT/3600
        if !TimeZone.current.isDaylightSavingTime() {
            //hours = hours - 1
        }
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .hour, value: hours, to: self as Date)
        return date! as NSDate
        
    }
    
}


