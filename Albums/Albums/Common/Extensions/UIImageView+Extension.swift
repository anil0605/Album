//
//  UIImageView+Extension.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

let cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func setImageOnItSelf(_ image: UIImage) {
        //print("width \(image.size.width)")
        //print("height \(image.size.height)")

        if image.size.width > image.size.height {
            //print("scaleAspectFit")
            self.contentMode = .scaleToFill
        } else {
            //print("scaleAspectFill")
            self.contentMode = .scaleToFill
        }
        self.image = image
        
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        
        if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage {
            setImageOnItSelf(imageFromCache)
            return
        }
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.setImageOnItSelf(image)
                cache.setObject(image, forKey: url as AnyObject)
            }
            }.resume()
    }
    
    public func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        if let encodedUrl = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            guard let url = URL(string: encodedUrl) else { return }
            downloadedFrom(url: url, contentMode: mode)
        }
    }
    
}
