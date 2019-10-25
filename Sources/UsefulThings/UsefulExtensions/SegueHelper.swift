//
//  SegueHelper.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation

/// Compares two segues and in case are equals it performs given action. The purpose of this structure is to eliminate the "if segue.identifier == "" repeating block or even worse some kind of switch. It also helps  user to not handle crash in case the segue is not available - but the names should be defined and passed to the array. I have hoped that it reminds you in case you are implementing new segue and so on."
public struct SegueHelper {
    
    let wanted:String?
    let given:String?
    let action:()->()
    
    /// <#Description#>
    /// - Parameter availableSegues: <#availableSegues description#>
    public func perform(availableSegues:[String]) {
        
        guard wanted != nil else {
            return
        }
        guard given != nil else {
            return
        }
        guard availableSegues.contains(given!) && availableSegues.contains(given!) else {
            return
        }
        if wanted == given {
            action()
        }
    }
}
