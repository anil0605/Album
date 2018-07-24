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
    
    // generate the url based on the parameters passed by the application
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
    
    //create network connection and retreive the data
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
  
}
