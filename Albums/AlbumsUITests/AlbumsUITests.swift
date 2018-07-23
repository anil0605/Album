//
//  AlbumsUITests.swift
//  AlbumsUITests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import XCTest

class AlbumsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testCollectionViewDataExists() {
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
    }
    
    func testCheckLayouts() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        
        let element = collectionViewsQuery.cells.children(matching: .other).element
        element.children(matching: .other).element.tap()
        
        let element2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element
        element2.tap()
        
      
        element.swipeLeft()
        element.swipeLeft()
        element.swipeRight()
        element.swipeRight()

    }
    
    func testOrientation(){
        
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .collectionView).element.swipeRight()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 5).children(matching: .other).element.tap()
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait

    }
    
    func testScrollingCollectionView(){
        
        let app = XCUIApplication()
        let collectionView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .collectionView).element
        collectionView.swipeUp()
        collectionView.swipeUp()
        collectionView.swipeUp()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        collectionViewsQuery.cells.children(matching: .other).element.tap()
        
    }
    
    
    
    
}
