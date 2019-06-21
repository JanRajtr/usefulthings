//
//  String.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

public extension String {
    
    
    
    /// Function generates SHA256 in `String` format. Hash is generated from data of `String` described in UTF8.
    /// - returns: 'SHA256' hash value of self.
    func get_sha256_String() -> String {
        guard let data = self.data(using: .utf8) else {
            print("Data not available")
            return ""
        }
        return getHexString(fromData: digest(input: data as NSData))
    }
    
    func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hashValue = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hashValue)
        return NSData(bytes: hashValue, length: digestLength)
    }
    
    func getHexString(fromData data: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: data.length)
        data.getBytes(&bytes, length: data.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func uncapitalizeFirstLetter() -> String {
        let first = String(self.prefix(1)).lowercased()
        let other = String(self.dropFirst())
        return first + other
    }
    
    mutating func uncapitalize() {
        self = self.uncapitalizeFirstLetter()
    }
    
    var uncapitalized:String {
        return self.uncapitalizeFirstLetter()
    }
    
    
    var snakeCased:String? {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
    }
    
    
    func snakeCase() -> String? {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
    }
    
    
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    
    var localized:String {
        return NSLocalizedString(self, comment: self)
        
    }
    
    func localize() -> String {
        return NSLocalizedString(self, comment: self)
        
    }
    
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
}

