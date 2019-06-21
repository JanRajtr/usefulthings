//
//  UIViewExtension.swift
//  Constructo
//
//  Created by Jan Rajtr on 15.08.17.
//  Copyright © 2017 Jan Rajtr. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func fadeInView() {
        let view = self
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: { () -> Void in
            view.layer.opacity = 1
        }, completion: nil)
    }
    
    func fadeOutView() {
        let view = self
        view.layer.opacity = 1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: { () -> Void in
            view.layer.opacity = 0
        }, completion: nil)
    }
    
    func fadeInView(duration:Double, completion:@escaping (Bool)->Void) {
        let view = self
        view.layer.opacity = 0.1
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: { () -> Void in
            view.layer.opacity = 1
        }, completion: completion)
    }
    
    func fadeOutView(duration:Double, completion:@escaping (Bool)->Void) {
        let view = self
        view.layer.opacity = 1
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: { () -> Void in
            view.layer.opacity = 0
        }, completion: completion)
    }
    
    func fadeInView(completion:@escaping (Bool)->Void) {
        let view = self
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: { () -> Void in
            view.layer.opacity = 1
        }, completion: completion)
    }
    
    func fadeOutView(completion:@escaping (Bool)->Void) {
        let view = self
        view.layer.opacity = 1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: { () -> Void in
            view.layer.opacity = 0
        }, completion: completion)
    }
    
    func image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    
}

