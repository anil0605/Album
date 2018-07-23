//
//  GridLayout.swift
//  Albums
//
//  Created by Anil Kothari on 20/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    private let itemsPerRow: CGFloat = 2
    private var insets = UIEdgeInsets.zero
    private let spacing : CGFloat = 8

    override init() {
        super.init()
        insets = UIEdgeInsets(top: spacing, left: spacing , bottom: spacing, right: spacing)
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
        minimumInteritemSpacing = spacing
        minimumLineSpacing = spacing
        scrollDirection = .vertical
        sectionInset = insets
    }
    
    func itemWidth() -> CGFloat {
        let paddingSpace = insets.left * (itemsPerRow )
        let availableWidth = collectionView!.frame.width - paddingSpace
        let widthPerItem = (availableWidth - paddingSpace) / itemsPerRow
        return widthPerItem
    }
    
    func itemHeight() -> CGFloat {
        return itemWidth()
    }
    
    override var itemSize: CGSize {
        set {
            let dimension = itemWidth()
            self.itemSize = CGSize(width: dimension, height: dimension)
        }
        get {
            let dimension = itemWidth()
            return CGSize(width: dimension, height: dimension)
        }
    }
    
}
