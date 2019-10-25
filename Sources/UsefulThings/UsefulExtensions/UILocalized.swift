//
//  UILocalized.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//
#if os(iOS) || os(watchOS) || os(tvOS)
import Foundation
import UIKit
import CryptoKit

class UILocalizedLabel: UILabel {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        let text = self.text
        if text != nil {
            self.text = NSLocalizedString(text!, comment: "")
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let text = self.text
        if text != nil {
            self.text = NSLocalizedString(text!, comment: "")
        }
    }
    
    
}
#elseif os(OSX)

#else
    
#endif

