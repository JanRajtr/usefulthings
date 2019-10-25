//
//  NSDataExtension.swift
//  Constructo
//
//  Created by Jan Rajtr on 16.08.17.
//  Copyright © 2017 Jan Rajtr. All rights reserved.
//

import Foundation
import CommonCrypto

enum DataCompressionTypes:String {
    case zlib
}

extension Data {
    /*
    init?(fromCompressedBase64:String, compression:DataCompressionTypes) {
        
        if compression == .zlib {
            let data = Data(base64Encoded: fromCompressedBase64)
            guard data != nil else {
                return nil
                
            }
            let decompressed = data?.decompress(withAlgorithm: .zlib)
            guard decompressed != nil else {
                return nil
            }
            self = decompressed!
        } else {
            return nil
        }
        
        
        
    }
    
    func compressAndBase64(compression:DataCompressionTypes) -> String? {
        if compression == .zlib {
            let compressed = self.compress(withAlgorithm: .zlib)?.base64EncodedString()
            return compressed
        }
        return nil
    }
     */
}

extension NSData {
    
    /// Function creates SHA256 HASH from base64 encoded NSData.
    func sha256() -> String {
        
        //let nameOfContentAttribute:String = self.entity.name!.lowercased() + "Content"
        //let content:Data? = self.value(forKey: nameOfContentAttribute) as? Data
        let content:NSData = self
        let base64content:Data = content.base64EncodedData()
        let string = String.init(data: base64content, encoding: .utf8)
        let data = string?.data(using: .utf8)
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(((data! as NSData)).bytes, CC_LONG(data!.count), res?.mutableBytes.assumingMemoryBound(to: UInt8.self))
        let hashedString = "\(res!)".replacingOccurrences(of: "", with: "").replacingOccurrences(of: " ", with: "")
        let badchar: CharacterSet = CharacterSet(charactersIn: "\"<\",\">\"")
        let cleanedstring: String = (hashedString.components(separatedBy: badchar) as NSArray).componentsJoined(by: "")
        return cleanedstring
        
    }
    
    
    
}




extension Data {
    
    /// Function creates SHA256 HASH from base64 encoded NSData.
    func sha256() -> String {
        
        //let nameOfContentAttribute:String = self.entity.name!.lowercased() + "Content"
        //let content:Data? = self.value(forKey: nameOfContentAttribute) as? Data
        let content:Data = self
        let base64content:Data = content.base64EncodedData()
        let string = String.init(data: base64content, encoding: .utf8)
        let data = string?.data(using: .utf8)
        let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(((data! as NSData)).bytes, CC_LONG(data!.count), res?.mutableBytes.assumingMemoryBound(to: UInt8.self))
        let hashedString = "\(res!)".replacingOccurrences(of: "", with: "").replacingOccurrences(of: " ", with: "")
        let badchar: CharacterSet = CharacterSet(charactersIn: "\"<\",\">\"")
        let cleanedstring: String = (hashedString.components(separatedBy: badchar) as NSArray).componentsJoined(by: "")
        return cleanedstring
        
    }
    
    
    
}

extension Data {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
    
    func sizeInMB() -> String {
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self.count))
        return string
        
    }
}
