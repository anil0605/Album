//
//  AlbumInteractorTests.swift
//  AlbumsTests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import XCTest
@testable import Albums

class AlbumInteractorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testClassNameEqualToString(){
        XCTAssertEqual(AlbumViewController.className, "AlbumViewController")
    }
    
    func testClassNameNotEqualToString(){
        XCTAssertNotEqual(AlbumViewController.className, "ViewController")
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
}
