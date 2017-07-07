//
//  UIView+Constraints.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


extension UIView {
    
    func addConstraintsAlignedToSuperview(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .top,
                relatedBy: .equal,
                toItem: superview,
                attribute: .top,
                multiplier: 1,
                constant: top
            )
        )
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .leading,
                relatedBy: .equal,
                toItem: superview,
                attribute: .leading,
                multiplier: 1,
                constant: leading
            )
        )
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: superview,
                attribute: .bottom,
                multiplier: 1,
                constant: bottom
            )
        )
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: superview,
                attribute: .trailing,
                multiplier: 1,
                constant: trailing
            )
        )
    }
}
