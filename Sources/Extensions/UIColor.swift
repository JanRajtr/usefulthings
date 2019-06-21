//
//  UIColor.swift
//  Constructo
//
//  Created by Jan Rajtr on 21.05.18.
//  Copyright © 2018 Jan Rajtr. All rights reserved.
//

import Foundation

extension UIColor {
    
    class func constructoYellow() -> UIColor {
        
        return #colorLiteral(red: 0.9845768809, green: 0.8452311754, blue: 0, alpha: 1)
    }
    
    
    class func constructoGray() -> UIColor {
        
        return #colorLiteral(red: 0.1921568627, green: 0.2196078431, blue: 0.2431372549, alpha: 1)
    }
    
    
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
