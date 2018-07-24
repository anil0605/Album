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

public typealias ImageCompletionHandler = (_ sucess : Bool) -> Void

extension UIImageView {
    
    func downloadedFrom(url: URL, completionHandler: @escaping ImageCompletionHandler) {
        
        if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            completionHandler(false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                    completionHandler(false)
                    return
                }
            DispatchQueue.main.async {
                self.image = image
                cache.setObject(image, forKey: url as AnyObject)
                completionHandler(true)
            }
            }.resume()
    }
    
    public func downloadedFrom(link: String, completionHandler: @escaping ImageCompletionHandler ) {
        if let encodedUrl = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            guard let url = URL(string: encodedUrl) else { return }
            downloadedFrom(url: url) { (sucess) in
                completionHandler(sucess)
            }
            
        }
    }
    
}
