//
//  PinterestLayoutDelegate.swift
//  PinterestLayout
//
//  Created by Roman Sorochak on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit


/**
 PinterestLayoutDelegate.
 */
@objc public protocol PinterestLayoutDelegate {
    /**
     Size for section header. Optional.
     
     @param collectionView - collectionView
     @param section - section for section header view
     
     Returns size for section header view.
     */
    @objc optional func collectionView(collectionView: UICollectionView,
                                       sizeForSectionHeaderViewForSection section: Int) -> CGSize
    /**
     Size for section footer. Optional.
     
     @param collectionView - collectionView
     @param section - section for section footer view
     
     Returns size for section footer view.
     */
    @objc optional func collectionView(collectionView: UICollectionView,
                                       sizeForSectionFooterViewForSection section: Int) -> CGSize
    /**
     Height for image view in cell.
     
     @param collectionView - collectionView
     @param indexPath - index path for cell
     
     Returns height of image view.
     */
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat
    
    /**
     Height for annotation view (label) in cell.
     
     @param collectionView - collectionView
     @param indexPath - index path for cell
     
     Returns height of annotation view.
     */
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat
}
