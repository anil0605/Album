//
//  AlbumsUITests.swift
//  AlbumsUITests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import XCTest

 // The UI test cases will test the AlbumViewController screen with layout's being configured correctly.

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
    
    // To test the close button is present on the image detail screen
    func testCloseButtonPresent(){
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()
        
        let button = app.buttons["Button"]
        XCTAssertTrue(button.exists)
    }
    
    //To check total images count label is present on the screen
    func testTotalImagePresentIdentifier(){
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts["totalImagesCount"].exists)
    }
    
    
    // To test the data is being present in the test cases.
    func testCollectionViewDataExists() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        
        XCTAssertTrue(element.exists)
        XCTAssertNotNil(element)
        element.tap()
    }
    
    // To test the orientation of the device is being present in both the directions.
    func testOrientation(){
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .collectionView).element
        
        XCTAssertTrue(element.exists)
        XCTAssertNotNil(element)
        
        element.swipeRight()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 5).children(matching: .other).element.tap()
        XCUIDevice.shared.orientation = .portraitUpsideDown
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait

    }
    
    // To test the collection view is being able to scrolled and item from the third page is being able to tapped.
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
