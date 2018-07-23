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
        imageView.downloadedFrom(link: url)
        
        let promise = expectation(description: "Image Downloaded Successfully")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            if self.imageView.image != nil {
                promise.fulfill()
                
                // Now it will pull from cache and immediately shown on screen
                let newImageView = UIImageView()
                newImageView.downloadedFrom(link: self.url)
                XCTAssertNotNil(newImageView.image)
            }else{
                XCTFail("Image downloading failed.")
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
