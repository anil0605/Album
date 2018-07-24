//
//  ImageDownloaderTest.swift
//  AlbumsTests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit
import XCTest
@testable import Albums

class ImageDownloader: XCTestCase {
    
    var imageView : UIImageView!
    var url : String!

    override func setUp() {
        super.setUp()
        imageView = UIImageView()
        url = "https://images.unsplash.com/photo-1532154830726-d999424566e2?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjMxNzU4fQ&s=f4645c8b8fa1052b9442a9bef1899d63"

    }
    
    func testIfImageDownloadedSuccessfully(){
        cache.removeAllObjects()
        
        let promise = expectation(description: "Image Downloaded Successfully")

        imageView.downloadedFrom(link: self.url) { (sucess) in
            if sucess {
                promise.fulfill()
                
                DispatchQueue.main.async {
                    let newImageView = UIImageView()
                    newImageView.downloadedFrom(link: self.url, completionHandler: { (sucess) in
                    })
                    XCTAssertNotNil(newImageView.image)
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
