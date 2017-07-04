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


class PinterestVC: UICollectionViewController {
    
    var images: [[UIImage]] = [
        [#imageLiteral(resourceName: "new_york"), #imageLiteral(resourceName: "bigben_river"), #imageLiteral(resourceName: "dubai"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "tiger"), #imageLiteral(resourceName: "5")],
        [#imageLiteral(resourceName: "adelaide_castle"), #imageLiteral(resourceName: "rys"), #imageLiteral(resourceName: "12"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "city"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "ph"), #imageLiteral(resourceName: "paris"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "bridge"), #imageLiteral(resourceName: "elephants")],
        [#imageLiteral(resourceName: "venice"), #imageLiteral(resourceName: "bw_new_york"), #imageLiteral(resourceName: "10"), #imageLiteral(resourceName: "kittens"), #imageLiteral(resourceName: "deer"), #imageLiteral(resourceName: "11"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "13"), #imageLiteral(resourceName: "squirell"), #imageLiteral(resourceName: "lion"), #imageLiteral(resourceName: "nature"), #imageLiteral(resourceName: "4")]
    ]
    
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
            bottom: 5,
            right: 5
        )
    }
    
    private func setupLayout() {
        guard let layout = collectionViewLayout as? PinterestLayout else { return }
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
    }
}


//MARK: UICollectionViewDataSource

extension PinterestVC: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let image = images[indexPath.section][indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        cell.image = image
        
        // bad way of setting text, but just for a test
        if indexPath.item % 2 == 0 {
            cell.descriptionLabel.text = "Very short description"
        } else {
            cell.descriptionLabel.text = "Tonight, there are no lovers walking down the park alleys. There are no kings in the castles, and the princesses die alone – they have no frogs or peas. Tonight, the inkpots are empty, and the words are uncountable. Tonight, all shouts are muffled by unbearable silence."
        }
        
        return cell
    }
}


//MARK: CollectionViewLayoutDelegate

extension PinterestVC: CollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView,
                        sizeForSectionHeaderViewForSection section: Int) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: 0
        )
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForImageAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        let image = images[indexPath.section][indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: withWidth, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.height
    }
    
    func collectionView(collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat {
        return 50
    }
}
