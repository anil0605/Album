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
    
    weak var delegate: ImageCompletion?
    
    func setPhotoCellWith(model: AlbumModel, showPhotoDescription: Bool = false){
        
        photoDescriptionView.isHidden = !showPhotoDescription
        
        setDetails(model.user)
        
        if let url = model.urlList?.thumbUrl, !url.isEmpty, let linkUrl = URL(string: url) {
            imageView.downloadedFrom(url: linkUrl) { (sucess) in
                if sucess {
                    self.delegate?.setImageCompletionCounter(counter: 0)
                }
            }
        } 
    }
    
    func setDetails(_ user : User?) {
        var authorName = "Author : "
        authorName += user?.username ?? "N/A"
        name.text = authorName
        
        var locationName = "Location : "
        locationName += user?.location ?? "N/A"
        location.text = locationName
        
        var authorBio = "Biography : "
        authorBio += user?.bio ?? "N/A"
        biography.text = authorBio
    }
    
    func makeFull() {
        superview?.bringSubview(toFront: self)
        isLarge = true
        photoDescriptionView.isHidden = false
        if let largeFrame = superview?.bounds {
            original = frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.1)
            frame = largeFrame
            fadeOut()
            UIView.commitAnimations()
        }
    }

    func makeSmall() {
        isLarge = false
        photoDescriptionView.isHidden = true
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        frame = original
        fadeIn()
        UIView.commitAnimations()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
