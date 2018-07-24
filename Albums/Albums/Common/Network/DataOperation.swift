//
//  DataOperation.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import Foundation
import UIKit
public typealias CompletionHandler<T> = (Data?, Error?) -> Void

class DataOperation {
    
    var baseURL : String?
    var queryParam = [String: String]()
    
    func generateUrl() -> URL? {
        guard let baseUrl = baseURL, baseUrl.count > 0 else {
            return nil
        }
        var fullUrl = baseUrl
        
        fullUrl += queryParam.count > 0 ? "?" : ""
        
        for (key, value) in queryParam {
            fullUrl += "\(key)=\(value)&"
        }
        
        return URL(string: String(fullUrl.dropLast()))
    }
    
    func makeNetworkCallWith(completionHandler: @escaping CompletionHandler<Any>) {
        // Set up the URL request
        
        guard let url = generateUrl() else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            completionHandler(data, error)
        }
                
        task.resume()
    }
    
    
    func downloadedImageFrom(link: String, completionHandler: @escaping ImageCompletionHandler) {
       
        guard let encodedUrl = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: encodedUrl)
            else {
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
                cache.setObject(image, forKey: url as AnyObject)
                completionHandler(true)
            }
            }.resume()
    }
}
