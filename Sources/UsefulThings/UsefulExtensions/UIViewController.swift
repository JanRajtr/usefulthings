//
//  UIViewController.swift
//  Constructo
//
//  Created by Jan Rajtr on 15.08.17.
//  Copyright © 2017 Jan Rajtr. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension UIViewController {
    public func addActionSheetForiPad(actionSheet: UIAlertController, ofView:UIView) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = ofView
            popoverPresentationController.sourceRect = CGRect(x: ofView.bounds.midX, y: ofView.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = [.any]
        }
    }
    
    public func addActionSheetForiPad(actionSheet: UIAlertController, sender: UIBarButtonItem) {
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
    }
    
    func alertError(title:String? = "ERROR", error:Error?, unknownErrorMessage:String? = "UNKNOWN") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error?.localizedDescription ?? unknownErrorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
}
