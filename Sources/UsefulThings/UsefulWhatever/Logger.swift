//
//  File.swift
//  
//
//  Created by Jan Rajtr on 30/10/2019.
//

import Foundation

class Logger {
    
    static func log(message:String) {
        
        debugPrint(message)
    }
    
    static func log(prefix:String..., message:String) {
        var prefixes = ""
        prefix.forEach { (p) in
            prefixes += "["+p+"]"
        }
        prefixes += ": "
        debugPrint(prefixes + message)
    }
    
    static func log(prefix:String..., error:Error) {
        var prefixes = ""
        prefix.forEach { (p) in
            prefixes += "["+p+"]"
        }
        prefixes += ": "
        debugPrint(prefixes + error.localizedDescription)
    }
}
