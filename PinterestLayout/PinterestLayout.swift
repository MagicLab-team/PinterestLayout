//
//  PinterestLayout.swift
//  PinterestLayout
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


//MARK: CollectionViewLayoutDelegate

public protocol CollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
}


//MARK: CollectionViewLayoutAttributes

public class CollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    public var imageHeight: CGFloat = 0
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CollectionViewLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CollectionViewLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}


//MARK: CollectionViewLayout

public class PinterestLayout: UICollectionViewLayout {
    
    public var delegate: CollectionViewLayoutDelegate!
    public var numberOfColumns: Int = 1
    public var cellPadding: CGFloat = 0
    public var numberOfSections: Int = 1
    var insets = UIEdgeInsets.zero
    
    private var cache = [CollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            insets = collectionView!.contentInset
            let bounds = collectionView!.bounds
            return bounds.width - insets.left - insets.right
        }
    }
    
    override public var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    override public class var layoutAttributesClass: AnyClass {
        return CollectionViewLayoutAttributes.self
    }
    
    override public func prepare() {
        
        if cache.isEmpty {
            let collumnWidth = width / CGFloat(numberOfColumns)
            let cellWidth = collumnWidth - (cellPadding * 2)
            
            var xOffsets = [CGFloat]()
            
            for collumn in 0..<numberOfColumns {
                xOffsets.append(CGFloat(collumn) * collumnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            for section in 0..<numberOfSections {
                
                var column = 0
                var oneColumn = Int(collectionView!.numberOfItems(inSection: section)/numberOfColumns)
                if collectionView!.numberOfItems(inSection: section) % numberOfColumns != 0 {
                    oneColumn += 1
                }
                for item in 0..<collectionView!.numberOfItems(inSection: section) {
                    
                    let indexPath = IndexPath(item: item, section: section)
                    
                    column = Int(item/(oneColumn))
                    
                    let imageHeight = delegate.collectionView(collectionView: collectionView!, heightForImageAtIndexPath: indexPath as NSIndexPath, withWidth: cellWidth)
                    let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath as NSIndexPath, withWidth: cellWidth)
                    let cellHeight = cellPadding + imageHeight + annotationHeight + cellPadding
                    
                    let frame = CGRect(
                        x: xOffsets[column],
                        y: yOffsets[column],
                        width: collumnWidth,
                        height: cellHeight)
                    let insetFrame = UIEdgeInsetsInsetRect(frame, insets)
                    
                    let attributes = CollectionViewLayoutAttributes(
                        forCellWith: indexPath
                    )
                    attributes.frame = insetFrame
                    attributes.imageHeight = imageHeight
                    cache.append(attributes)
                    
                    let cgrectFrame = frame
                    contentHeight = max(contentHeight, cgrectFrame.maxY)
                    yOffsets[column] = yOffsets[column] + cellHeight
                }
            }
        }
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}
