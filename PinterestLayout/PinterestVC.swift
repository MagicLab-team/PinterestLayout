//
//  PinterestVC.swift
//  PinterestLayout
//
//  Created by Roman Sorochak on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


public struct PinterestItem {
    public var image: UIImage
    public var text: String
    
    public init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
}


/**
 PinterestVC.
 */
open class PinterestVC: UICollectionViewController, PinterestLayoutDelegate {
    
    private var _items: [PinterestItem]?
    open var items: [PinterestItem] {
        get {
            return _items ?? [PinterestItem]()
        }
        set {
            _items = newValue
        }
    }
    
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewInsets()
        setupLayout()
        
        collectionView?.register(
            PinterestCell.self,
            forCellWithReuseIdentifier: pinterestCellIdentifier
        )
    }
    
    //MARK: private
    
    private func setupCollectionViewInsets() {
        collectionView!.backgroundColor = .clear
        collectionView!.contentInset = UIEdgeInsets(
            top: 15,
            left: 5,
            bottom: 5,
            right: 5
        )
    }
    
    private func setupLayout() {
        let layout: PinterestLayout = {
            if let layout = collectionViewLayout as? PinterestLayout {
                return layout
            }
            let layout = PinterestLayout()
            
            collectionView?.collectionViewLayout = layout
            
            return layout
        }()
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
    }
    
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        let image = items[indexPath.item].image
        
        return image.height(forWidth: withWidth)
    }
    
    public func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        let text = items[indexPath.item].text
        let font = UIFont.defaultFont
        
        let textHeight = text.heightForWidth(width: withWidth, font: font) 
        
        return PinterestCell.annotationPadding * 2 + textHeight
    }
    
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: pinterestCellIdentifier,
            for: indexPath) as! PinterestCell
        
        let item = items[indexPath.item]
        
        cell.imageView.image = item.image
        cell.descriptionLabel.text = item.text
        
        return cell
    }
}
