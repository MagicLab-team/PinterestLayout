//
//  PinterestVC.swift
//  PinterestLayoutExample
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import PinterestLayout
import AVFoundation


class MyPinterestVC: PinterestVC {
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "Some text. Some text. Some text. Some text."
        
        items = [
            PinterestItem(image: #imageLiteral(resourceName: "new_york"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "bigben_river"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "dubai"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "4"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "tiger"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "5"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "adelaide_castle"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "rys"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "12"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "cat"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "6"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "city"), text: text),
            PinterestItem(image: #imageLiteral(resourceName: "9"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "ph"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "paris"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "2"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "bridge"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "elephants"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "venice"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "bw_new_york"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "10"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "kittens"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "deer"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "11"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "8"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "13"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "squirell"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "lion"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "nature"), text: "Some text"),
            PinterestItem(image: #imageLiteral(resourceName: "4"), text: "Some text"),
        ]
        
        collectionView?.contentInset = UIEdgeInsets(
            top: 20,
            left: 5,
            bottom: 49,
            right: 5
        )
    }
}
