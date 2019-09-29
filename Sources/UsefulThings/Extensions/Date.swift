//
//  DateExtension.swift
//  Constructo
//
//  Created by Jan Rajtr on 15.08.17.
//  Copyright © 2017 Jan Rajtr. All rights reserved.
//

import Foundation

/// Formats of the dates available for function of with(:_).
public enum DateFormats:String {
    case ddMMyyyy = "dd.MM.yyyy"
    case ddMMyyyyHHmmss = "dd.MM.yyyy HH:mm:ss"
    case SQLString = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMdd_HHmmss_0000 = "yyyy-MM-dd HH:mm:ss +0000"
    case yyyy = "yyyy"
    case MMYYYY = "MM.YYYY"
    case DDMM = "dd.MM"
    case MM = "MM."
    case dd = "dd."
    case EEEE = "EEEE"
    case LLLL = "LLLL"
    case ISO = "yyyy-MM-dd'T'HH:mm:ssZ"
}

public enum DateLocale:String {
    case enUsPosix = "en_US_POSIX"
}


public extension Date {
    
    static func from(string:String, format:DateFormats, locale:DateLocale?) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        if locale != nil {
            dateFormatter.locale = Locale(identifier: locale!.rawValue)
        }
        
        let date = dateFormatter.date(from:string)
        return date
    }
    
    /// Returns the Date in given string format.
    /// - Returns: The date in string.
    /// - Parameter format: Date format in which the date should be returned.
    func with(format:DateFormats) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self as Date)
    }
    

    /// Returns `String` representation of given `Date` class in MySQL format
    /// - returns:
    ///     - `String` value in "yyyy-MM-dd'T'HH:mm:ss.SSSZ" format
    func toSQLString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self as Date)
    }
    /// Returns `String` part  of given `Date`
    /// - returns:
    ///     - `String` day of the given date
    var day:String {
        return self.with(format: .dd)
    }
    
    /// Returns `String` part  of given `Date`
    /// - returns:
    ///     - `String` month of the given date
    var month:String {
        return self.with(format: .MM)
    }
    
    /// Returns `String` part  of given `Date`
    /// - returns:
    ///     - `String` month and year of the given date
    var monthAndYear:String {
        return self.with(format: .MMYYYY)
    }
    
    /// Returns `String` part  of given `Date`
    /// - returns:
    ///     - `String` year of the given date
    var year:String {
        return self.with(format: .yyyy)
    }
    
    
    
    
    /// Returns _Date_ object from given string in MySQL format
    /// - parameters:
    ///     - date:`String` - value of Date, usually received via REST from server
    /// - returns:
    ///     Given string date as `Date` object.
    func fromSQLString(date:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = date
        if let datePublished = dateFormatter.date(from: dateString) {
            return datePublished as Date
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
            if let datePublished = dateFormatter.date(from: dateString) {
                return datePublished as Date
            }
            return Date()
        }
    }
    
    
    
    /// Returns `Date` value of given string in format:
    ///
    ///     "dd.MM.yyyy HH:mm:ss"
    ///
    /// or `nil` in case the given format does not correspond with described form.
    /// - parameters:
    ///     - date:     `String` value in format "dd.MM.yyyy HH:mm:ss"
    /// - returns:      `Date` value of given _stringly_ described date or actual Date() in case the recoding will not succeed
    /// - warning:      It is predictable that this function in next versions will return `nil` instead of `Date()` in case of failure.
    func fromReadableString(date:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let dateString = date
        if let datePublished = dateFormatter.date(from: dateString) {
            return datePublished as Date
        } else {
            return Date()
        }
    }
    
    
    /// Recalculates the given date to UTC date accroding to current timezone.
    func fromCurrentToUTC() -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let current:String = dateFormatter.string(from: self)
        let currentDate = dateFormatter.date(from: current)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcDate = dateFormatter.string(from: currentDate!)
        return dateFormatter.date(from: utcDate)!
        
    }
    
    /// Recalculates the given date from UTC date accroding to current timezone.
    func fromUTCToCurrent() -> Date {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        
        // Creating String of the date used to transformation
        let utc = dateFormatter.string(from: self)
        
        // Creating date of the string
        let utcDate = dateFormatter.date(from: utc)
        
        // Settings up the current timezone
        dateFormatter.timeZone = TimeZone.current
        
        // Creating string of the current date
        let currentDate = dateFormatter.string(from: utcDate!)
        
        // Returning
        return dateFormatter.date(from: currentDate)!
    }
    
    /// Returns localized name of the month for the given date.
    func monthName() -> String {
        let date = self
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let monthNumber = month-1
        let df = DateFormatter()
        let name = df.monthSymbols[monthNumber]
        
        return NSLocalizedString(name, comment: "")
    }
    
    /// Returns the amount of years from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of years in `Date`.
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of months in `Date`.
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of weeks in `Date` or 0.
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of days in `Date` or 0.
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of hours in `Date` or 0.
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of minutes in `Date` or 0.
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `Int` number of seconds in `Date` or 0.
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    /// - parameters:
    ///     - date: `Date` which will be used for calculations.
    /// - returns:  `String` custom time interval description from another `Date`.
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
}


