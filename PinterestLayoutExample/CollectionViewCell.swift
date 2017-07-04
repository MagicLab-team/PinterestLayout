//
//  CollectionViewCell.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import PinterestLayout


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            } else {
                imageView.backgroundColor = .lightGray
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! CollectionViewLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.imageHeight
    }
}
