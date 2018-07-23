//
//  PhotoCell.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var photoDescriptionView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var biography: UILabel!
    
    var isLarge = false
    var original : CGRect = CGRect.zero
    
    func setPhotoCellWith(model: AlbumModel, showPhotoDescription: Bool = false){
        if let url = model.urlList?.thumbUrl, !url.isEmpty {
            imageView.downloadedFrom(link: url)
        }
        if let user = model.user {
            name.text = user.username ?? ""
            location.text = user.location ?? ""
            biography.text = user.bio ?? ""
        }
        
        photoDescriptionView.isHidden = !showPhotoDescription
    }
    
    func makeFull() {
        superview?.bringSubview(toFront: self)
        isLarge = true
        photoDescriptionView.isHidden = false
        if let largeFrame = superview?.bounds {
            original = frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.1)
            self.frame = largeFrame
            self.fadeOut()
            UIView.commitAnimations()
        }
    }

    func makeSmall() {
        isLarge = false
        photoDescriptionView.isHidden = true
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        self.frame = original
        self.fadeIn()
        UIView.commitAnimations()
    }

    override func prepareForReuse() {
        imageView.image = nil
    }
    
}
