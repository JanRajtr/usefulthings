//
//  CAShapeLayerExtensions.swift
//  UsefulThings
//
//  Created by Jan Rajtr on 21.06.19.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//

import Foundation

extension CAShapeLayer {
    
    /// Creates Rounded rectangle with given parameters in the current 'CAShapeLayer'.
    /// - parameters:
    ///     - rect:     'CGRect' rectangle dimensions.
    ///     - color:    'UIColor' of the rectangle.
    ///     - filled:   'Bool' value indicating if the rectangle should be filled.
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
    
}
