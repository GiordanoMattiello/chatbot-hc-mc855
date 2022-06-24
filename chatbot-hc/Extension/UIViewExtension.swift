//
//  UIViewExtension.swift
//  chatbot-hc
//
//  Created by Giordano Mattiello on 08/06/22.
//

import UIKit

extension UIView {
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.75
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 1)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width+20,
                                                     height: layer.shadowRadius)).cgPath
    }
    func addTopShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.75
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 1)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.minY - layer.shadowRadius,
                                                     width: bounds.width+20,
                                                     height: layer.shadowRadius)).cgPath
    }
    
}
