//
//  ViewAnimationTests.swift
//  AlbumsTests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit
import XCTest
@testable import Albums

class ViewAnimationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func testView(){
        let view = UIView()
        view.fadeIn()
        XCTAssertEqual(view.alpha, 1.0)
    }
    
    func testView1(){
        let view = UIView()
        view.fadeOut()
        XCTAssertEqual(view.alpha, 0.0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
