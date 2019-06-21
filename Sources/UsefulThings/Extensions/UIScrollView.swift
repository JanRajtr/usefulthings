//
//  UIScrollView.swift
//  Constructo
//
//  Created by Jan Rajtr on 24/04/2019.
//  Copyright © 2019 Jan Rajtr. All rights reserved.
//


import UIKit

extension UIScrollView {
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
    
    func scrollToBottom() {
        let contentHeight = contentSize.height - frame.size.height
        let contentoffsetY = contentHeight > 0 ? contentHeight : 0
        setContentOffset(CGPoint(x: 0, y: contentoffsetY), animated: false)
    }
    
}
