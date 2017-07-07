//
//  CustomCollectionVC.swift
//  PinterestLayout
//
//  Created by Roman Sorochak on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import PinterestLayout


class CustomCollectionVC: UICollectionViewController {
    
    var images: [UIImage] = [#imageLiteral(resourceName: "new_york"), #imageLiteral(resourceName: "bigben_river"), #imageLiteral(resourceName: "dubai"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "tiger"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "adelaide_castle"), #imageLiteral(resourceName: "rys"), #imageLiteral(resourceName: "12"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "city"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "ph"), #imageLiteral(resourceName: "paris"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "bridge"), #imageLiteral(resourceName: "elephants"), #imageLiteral(resourceName: "venice"), #imageLiteral(resourceName: "bw_new_york"), #imageLiteral(resourceName: "10"), #imageLiteral(resourceName: "kittens"), #imageLiteral(resourceName: "deer"), #imageLiteral(resourceName: "11"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "13"), #imageLiteral(resourceName: "squirell"), #imageLiteral(resourceName: "lion"), #imageLiteral(resourceName: "nature"), #imageLiteral(resourceName: "4")]
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewInsets()
        setupLayout()
    }
    
    //MARK: private
    
    private func setupCollectionViewInsets() {
        collectionView!.backgroundColor = .clear
        collectionView!.contentInset = UIEdgeInsets(
            top: 15,
            left: 5,
            bottom: 49,
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
}


//MARK: UICollectionViewDataSource

extension CustomCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CollectionCell",
            for: indexPath) as! CollectionViewCell
        
        let image = images[indexPath.item]
        
        cell.imageView.image = image
        
        return cell
    }
}


//MARK: PinterestLayoutDelegate

extension CustomCollectionVC: PinterestLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        let image = images[indexPath.item]
        
        return image.height(forWidth: withWidth)
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        return 0
    }
}

