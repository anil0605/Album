//
//  DataOperation.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import Foundation
import UIKit
public typealias CompletionHandler = (Data?, Error?) -> Void

class DataOperation {
    
    var baseURL : String?
    var queryParam = [String: String]()
    
    // generate the url based on the parameters passed by the application
    public func generateUrl() -> URL? {
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
    
    //create network connection and retreive the data
    public func makeNetworkCallWith(completionHandler: @escaping CompletionHandler) {
        // Set up the URL request
        
        guard let url = generateUrl() else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let queueIdentifier = "com.loblaw.albumData"
        let backgroundQueue = DispatchQueue(label: queueIdentifier, qos: DispatchQoS.background)
        
        backgroundQueue.async {
            // make the request
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                
                completionHandler(data, error)
            }
            
            task.resume()
        }
        
    }
    
    //create download task connection in background queue and return data back
    public static func downloadedTaskFrom(url: URL, completionHandler: @escaping CompletionHandler) {
        let queueIdentifier = "com.loblaw.albumImage"
        let backgroundQueue = DispatchQueue(label: queueIdentifier, qos: DispatchQoS.background)
        
        backgroundQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data, error == nil
                    else {
                        completionHandler(nil, error)
                        return
                }
                completionHandler(data, nil)
                }.resume()
        }
    }
}
