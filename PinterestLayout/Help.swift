//
//  UIView+Constraints.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import AVFoundation


public extension UIImage {
    /**
     Calculates the best height of the image for available width.
     */
    public func height(forWidth width: CGFloat) -> CGFloat {
        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        let rect = AVMakeRect(
            aspectRatio: size,
            insideRect: boundingRect
        )
        return rect.size.height
    }
}


public extension String {
    /**
     Calculates the best height of the text for available width and font used.
     */
    public func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: font],
            context: nil
        )
        return ceil(rect.height)
    }
}

extension UIFont {
    
    class var defaultFont: UIFont {
        return UIFont(name: "Arial-ItalicMT", size: 11)!
    }
}


extension UIView {
    
    func addConstraintsAlignedToSuperview(top: CGFloat = 0,
                                          leading: CGFloat = 0,
                                          bottom: CGFloat = 0,
                                          trailing: CGFloat = 0) {
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
