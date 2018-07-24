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
        let dataNotAvailable = NSLocalizedString(AlbumString.TitleDataNotAvailableStaticText.rawValue, comment: "")
        var authorName = NSLocalizedString(AlbumString.AuthorNameStaticText.rawValue, comment: "")
        authorName += user?.username ?? dataNotAvailable
        name.text = authorName
        
        var locationName = NSLocalizedString(AlbumString.ImageLocationStaticText.rawValue, comment: "")
        locationName += user?.location ?? dataNotAvailable
        location.text = locationName
        
        var authorBio = NSLocalizedString(AlbumString.AuthorBiographyStaticText.rawValue, comment: "")
        authorBio += user?.bio ?? dataNotAvailable
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
