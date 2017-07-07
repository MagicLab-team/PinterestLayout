//
//  PinterestLayout.swift
//  PinterestLayout
//
//  Created by Roman Sorochak on 7/4/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


/**
 PinterestLayout.
 */
public class PinterestLayout: UICollectionViewLayout {
    
    /**
     Delegate.
     */
    public var delegate: PinterestLayoutDelegate!
    /**
     Number of columns.
     */
    public var numberOfColumns: Int = 1
    /**
     Cell padding.
     */
    public var cellPadding: CGFloat = 0
    
    
    private var cache = [PinterestLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        get {
            let bounds = collectionView.bounds
            let insets = collectionView.contentInset
            return bounds.width - insets.left - insets.right
        }
    }
    
    override public var collectionViewContentSize: CGSize {
        get {
            return CGSize(
                width: contentWidth,
                height: contentHeight
            )
        }
    }
    
    override public class var layoutAttributesClass: AnyClass {
        return PinterestLayoutAttributes.self
    }
    
    override public var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    private var numberOfSections: Int {
        return collectionView.numberOfSections
    }
    
    private func numberOfItems(inSection section: Int) -> Int {
        return collectionView.numberOfItems(inSection: section)
    }
    
    /**
     Invalidates layout.
     */
    override public func invalidateLayout() {
        cache.removeAll()
        contentHeight = 0
        
        super.invalidateLayout()
    }
    
    override public func prepare() {
        if cache.isEmpty {
            let collumnWidth = contentWidth / CGFloat(numberOfColumns)
            let cellWidth = collumnWidth - (cellPadding * 2)
            
            var xOffsets = [CGFloat]()
            
            for collumn in 0..<numberOfColumns {
                xOffsets.append(CGFloat(collumn) * collumnWidth)
            }
            
            for section in 0..<numberOfSections {
                let numberOfItems = self.numberOfItems(inSection: section)
                
                if let headerSize = delegate.collectionView?(
                    collectionView: collectionView,
                    sizeForSectionHeaderViewForSection: section
                    ) {
                    let headerX = (contentWidth - headerSize.width) / 2
                    let headerFrame = CGRect(
                        origin: CGPoint(
                            x: headerX,
                            y: contentHeight
                        ),
                        size: headerSize
                    )
                    let headerAttributes = PinterestLayoutAttributes(
                        forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                        with: IndexPath(item: 0, section: section)
                    )
                    headerAttributes.frame = headerFrame
                    cache.append(headerAttributes)
                    
                    contentHeight = headerFrame.maxY
                }
                
                var yOffsets = [CGFloat](
                    repeating: contentHeight,
                    count: numberOfColumns
                )
                
                for item in 0..<numberOfItems {
                    let indexPath = IndexPath(item: item, section: section)
                    
                    let column = yOffsets.index(of: yOffsets.min() ?? 0) ?? 0
                    
                    let imageHeight = delegate.collectionView(
                        collectionView: collectionView,
                        heightForImageAtIndexPath: indexPath,
                        withWidth: cellWidth
                    )
                    let annotationHeight = delegate.collectionView(
                        collectionView: collectionView,
                        heightForAnnotationAtIndexPath: indexPath,
                        withWidth: cellWidth
                    )
                    let cellHeight = cellPadding + imageHeight + annotationHeight + cellPadding
                    
                    let frame = CGRect(
                        x: xOffsets[column],
                        y: yOffsets[column],
                        width: collumnWidth,
                        height: cellHeight
                    )
                    
                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                    let attributes = PinterestLayoutAttributes(
                        forCellWith: indexPath
                    )
                    attributes.frame = insetFrame
                    attributes.imageHeight = imageHeight
                    cache.append(attributes)
                    
                    contentHeight = max(contentHeight, frame.maxY)
                    yOffsets[column] = yOffsets[column] + cellHeight
                }
                
                if let footerSize = delegate.collectionView?(
                    collectionView: collectionView,
                    sizeForSectionFooterViewForSection: section
                    ) {
                    let footerX = (contentWidth - footerSize.width) / 2
                    let footerFrame = CGRect(
                        origin: CGPoint(
                            x: footerX,
                            y: contentHeight
                        ),
                        size: footerSize
                    )
                    let footerAttributes = PinterestLayoutAttributes(
                        forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                        with: IndexPath(item: 0, section: section)
                    )
                    footerAttributes.frame = footerFrame
                    cache.append(footerAttributes)
                    
                    contentHeight = footerFrame.maxY
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
