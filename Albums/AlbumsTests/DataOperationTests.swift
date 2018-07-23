//
//  DataOperationTests.swift
//  AlbumsTests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import XCTest
@testable import Albums

class DataOperationTests: XCTestCase {
    private let baseUrl = "https://api.unsplash.com/photos/"
    private let clientId = "b590310bd7b4a24939406f852e42dd9b966fa54e261dd5fdd9ce106b8dccad3a"

    override func setUp() {
        super.setUp()
    }
    
    func testDataOperationUrlIsNil(){
        let dataOperation = DataOperation()
        XCTAssertNil(dataOperation.generateUrl())
    }
    
    func testDataOperationUrlIsNotNil(){
        let dataOperation = DataOperation()
        dataOperation.baseURL = baseUrl
        XCTAssertNotNil(dataOperation.generateUrl())
    }
    
    func testDataOperationUrlIsEqual(){
        let dataOperation = DataOperation()
        dataOperation.baseURL = baseUrl
        dataOperation.queryParam["page"] = "1"
        dataOperation.queryParam["client_id"] = "\(clientId)"

        XCTAssertEqual(dataOperation.generateUrl()?.absoluteString,"\(baseUrl)?page=1&client_id=\(clientId)")
    }
    func testClassNameNotEqualToString(){
        XCTAssertNotEqual(AlbumViewController.className, "ViewController")
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
}
