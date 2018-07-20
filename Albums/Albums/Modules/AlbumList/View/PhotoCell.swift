//
//  PhotoCell.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setPhotoCellWith(model: AlbumModel){
        userName.text = model.id
        imageView.downloadedFrom(link: model.urlList.thumbUrl)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
}
