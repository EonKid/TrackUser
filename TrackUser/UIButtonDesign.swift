//
//  UIButtonDesign.swift
//  FlyZone
//
//  Created by Dhruv Singh on 23/02/18.
//  Copyright © 2017 Dhruv. All rights reserved.
//

import UIKit
@IBDesignable

class UIButtonDesign: UIButton {
   
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setCorner()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setCorner()
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setCorner()
        }
    }
    
    func setCorner() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    override public func prepareForInterfaceBuilder() {
        setCorner()
    }
}
