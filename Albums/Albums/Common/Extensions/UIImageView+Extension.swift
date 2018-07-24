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

public typealias OperationStatusCompletionHandler = (_ sucess : Bool) -> Void

extension UIImageView {
    
    func downloadedFrom(url: URL, completionHandler: @escaping OperationStatusCompletionHandler) {
        
        if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            completionHandler(false)
            return
        }
        
        DataOperation.downloadedTaskFrom(url: url) { (data, error) in
            
            if let imageData = data, let image = UIImage(data: imageData){
                DispatchQueue.main.async {
                    self.image = image
                }
                cache.setObject(image, forKey: url as AnyObject)
                completionHandler(true)
            }
            completionHandler(false)

        }
        
        
    }
    
    public func downloadedFrom(link: String, completionHandler: @escaping OperationStatusCompletionHandler ) {
        if let encodedUrl = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            guard let url = URL(string: encodedUrl) else { return }
            downloadedFrom(url: url) { (sucess) in
                completionHandler(sucess)
            }
            
        }
    }
    
}
