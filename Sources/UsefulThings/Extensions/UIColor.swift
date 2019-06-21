//
//  UIColor.swift
//  Constructo
//
//  Created by Jan Rajtr on 21.05.18.
//  Copyright © 2018 Jan Rajtr. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
    
    var darkerComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        let r = coreImageColor.red < 1 ? coreImageColor.red + 0.1 : coreImageColor.red
        let g = coreImageColor.green < 1 ? coreImageColor.green + 0.1 : coreImageColor.green
        let b = coreImageColor.blue < 1 ? coreImageColor.blue + 0.1 : coreImageColor.blue
        
        return (r,g,b,coreImageColor.alpha)
        
    }
}
