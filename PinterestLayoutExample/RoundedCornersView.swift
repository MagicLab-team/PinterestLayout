//
//  RoundedCornersView.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


@IBDesignable
open class RoundedCornersView: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
