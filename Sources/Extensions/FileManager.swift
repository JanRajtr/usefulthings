//
//  FileManager.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation

/// Function clearTmpDirectory clears content of TMP folder. Wheever there is error the function silently echoes the error in the console.
/*
func clearTmpDirectory() {
    
    do {
        let tmpDirectory = try contentsOfDirectory(atPath: NSTemporaryDirectory())
        try tmpDirectory.forEach {[unowned self] file in
            let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
            try self.removeItem(atPath: path)
        }
        
    } catch {
        
        print(error)
        
    }
}
 */
