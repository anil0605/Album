//
//  DataOperation.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import Foundation
public typealias CompletionHandler<T> = (Data, Error?) -> Void

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
            //print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            //print(data!)
            //print(response!)
            //print(error ?? "NoErr")
            // make sure we got data
            guard let responseData = data else {
                //print("Error: did not receive data")
                return
            }
            
            completionHandler(responseData, error)
        }
        
        
        
        task.resume()
    }
}
