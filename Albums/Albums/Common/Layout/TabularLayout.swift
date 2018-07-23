//
//  TabularLayout.swift
//  Albums
//
//  Created by Anil Kothari on 20/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

class TabularLayout: UICollectionViewFlowLayout {
    
    private var insets = UIEdgeInsets.zero
    private let itemsPerRow: CGFloat = 1
    private let spacing : CGFloat = 8
    
    override init() {
        super.init()
        insets = UIEdgeInsets(top: spacing, left: 0 , bottom: spacing, right: 0)
        setupLayout()
    }
    
    /**
     Init method
     - parameter aDecoder: aDecoder
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        sectionInset = insets
    }
    
    func itemWidth() -> CGFloat {
        let paddingSpace = insets.left * (itemsPerRow ) * 0
        let availableWidth = collectionView!.frame.width - paddingSpace
        let widthPerItem = (availableWidth - paddingSpace) / itemsPerRow
        return widthPerItem
    }
    
    func itemHeight() -> CGFloat {
        return collectionView!.frame.height - (insets.top + insets.bottom)
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: itemHeight())
        }
        get {
            return CGSize(width: itemWidth(), height: itemHeight())
        }
    }
 
}
