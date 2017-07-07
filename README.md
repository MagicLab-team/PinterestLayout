# PinterestLayout

Custom collection view layout with different image and text sizes. 


|             PinterestVC         |         Custom Cell          |
|---------------------------------|------------------------------|
|![Demo](https://github.com/MagicLab-team/PinterestLayout/blob/master/PinterestLayoutExample/DemoAssets/Demo_1.gif)|![Demo](https://github.com/MagicLab-team/PinterestLayout/blob/master/PinterestLayoutExample/DemoAssets/Demo_2.gif)|

## Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Tips](#tips)
- [Contact us](#contact-us)
- [License](#license)


## Requirements

- iOS 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Reusable 1.0.0+.

To integrate Reusable into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'PinterestLayout'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### PinterestVC subclass

- All you need to do is to sublcass from PinterestVC and provide items to be shown.
- PinterestVC will calculate image and text sizes.

```swift
import UIKit
import PinterestLayout

class MyPinterestVC: PinterestVC {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "Some text. Some text. Some text. Some text."
        
        items = [
            PinterestItem(image: UIImage(named: "new_york"), text: text),
            PinterestItem(image: UIImage(named: "bigben_river"), text: text),
            PinterestItem(image: UIImage(named: "dubai"), text: text),
            PinterestItem(image: UIImage(named: "4"), text: text),
            PinterestItem(image: UIImage(named: "tiger"), text: text)
        ]
    }
}
```

### Using custom cell

0 - Import PinterestLayout
```swift
import PinterestLayout
```

1 - Set PinterestLayout to your collection view.
```swift
let layout = PinterestLayout()
collectionView.collectionViewLayout = layout
```

2 - Setup layout 
```swift
layout.delegate = self
layout.cellPadding = 5
layout.numberOfColumns = 2
```

3 - Implement methods of [PinterestLayoutDelegate](https://github.com/MagicLab-team/PinterestLayout/blob/master/PinterestLayout/PinterestLayoutDelegate.swift)
```swift 
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
```

- PinterestLayout provides public API to easily calculate the best imageview and text heigths based on available width. 

```swift
public extension UIImage {
    /**
     Calculates the best height of the image for available width.
     */
    public func height(forWidth width: CGFloat) -> CGFloat
//...
public extension String {
    /**
     Calculates the best height of the text for available width and font used.
     */
    public func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat 
```
- So implementation of PinterestLayoutDelegate might be:
```swift
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
        let textFont = UIFont(name: "Arial-ItalicMT", size: 11)!                
        return "Some text".heightForWidth(width: withWidth, font: textFont)
    }
}
```

4 - Create custom cell and apply [PinterestLayoutAttributes](https://github.com/MagicLab-team/PinterestLayout/blob/master/PinterestLayout/PinterestLayoutAttributes.swift)
- Example is [here](https://github.com/MagicLab-team/PinterestLayout/blob/master/PinterestLayoutExample/CollectionViewCell.swift)
```swift
class CollectionViewCell: UICollectionViewCell {
//...
override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            //change image view height by changing its constraint
            imageViewHeightLayoutConstraint.constant = attributes.imageHeight
        }
    }
}
```

## Tips

- PinterestLayout fully supports collection view headers and footers. So you can have may sections.
- In case you load data asynchronously please follow next steps:
1. Do not use PinterestVC as parent class to your view controller. Use [custom cell approach](#using-custom-cell).
2. Make sure server returns image sorce with its sizes (height and width)
```json
{
    "src": "/upload/resize_cache/iblock/8e7/204_265_2/8e7f1f04d5e835f596ef33da74946847.jpg",
    "width": 204,
    "height": 265
}
```
3. when data is loaded invalidate layout as well as reload data on collection view.
```swift
collectionView.collectionViewLayout.invalidateLayout()
collectionView.reloadData()
```

## Contact us

Contact our team on email - roman.sorochak@gmail.com


## License

Reusable is released under the MIT license. See [LICENSE](https://github.com/MagicLab-team/PinterestLayout/blob/master/LICENSE) for details.

