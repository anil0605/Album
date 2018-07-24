//
//  AlbumsTests.swift
//  AlbumsTests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import XCTest
@testable import Albums

// To test the album module with viper architecture is correctly set up, layout's is correct and the datasource is correctly set up in the application.
class AlbumsTests: XCTestCase {
    // System under test is AlbumViewController
    var sut: AlbumViewController!
    
    
    override func setUp() {
        super.setUp()
        sut = AppRouter.albumListViewController
        AppRouter.assembleAlbumScreen(vc: sut)
        
        _ = sut.view

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // To test the default layout of the collection view needs to be a grid layout
    func testIfDefaultCollectionViewFlowLayoutIsGrid(){
        XCTAssertTrue(sut.collectionView.collectionViewLayout is GridLayout)
    }
    
    //To check whether the pagination is being enabled or disable on the intial launch of the screen
    func testIfPaginationIsDisabledDefault() {
        XCTAssertTrue(sut.collectionView.isPagingEnabled == false)
    }
    
    // To check the collection view data source count should be 10 album models as each service call returns 10 items
    // If the api is down or the network connection or api is not responding in 15 seconds this test case will face.
    func testCollectionItemCountAfterFirstCall(){
        
        let connectionTimeOutValue = 15
        let promise = expectation(description: "Data Retrieved successfully")
        XCTAssertTrue(self.sut.dataSource.count == 0)
        
        //Check isFetch is false
        XCTAssertFalse(sut.isFetchingData)
        // Checking after connectionTimeOutValue from the point api is being hit
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            if self.sut.dataSource.count == 10 {
                promise.fulfill()
            }else{
                XCTFail("Data downloading failed.")
            }
        }
        waitForExpectations(timeout: TimeInterval(connectionTimeOutValue), handler: nil)
    }
    
    
    
    //To test the album storyboard is present in the bundle
    func testStoryboardIsNotNil(){
        let storyboard = AppRouter.mainStoryboard
        XCTAssertNotNil(storyboard)
    }
    
    //To test the album view controller is present in the bundle
    func testAlbumViewControllerIsNotNil(){
        let albumViewController = AppRouter.albumListViewController
        XCTAssertNotNil(albumViewController)
    }
    
    //Presentor cannot be nil after assembling of VIPER components
    func testPresenterNotNil() {
        XCTAssertNotNil(sut.presenter)
    }
    
    //To test viper is being correctly set in the application
    func testVIPERElementsAreNotNil() {
        let presenter = sut.presenter!
        // all the presenter VIPER elements should have corresponding componenets
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        
    }
    
    //To test if any cyclic dependency should not present in the viper set up
    func testPresenterViewIsSystemUnderTest() {
        XCTAssertTrue(sut.presenter!.view === sut)
    }
    
    // To test the correct instance of presenter is being present in the both interactor and view
    func testInteractorIsCoupledWithPresenter() {
        XCTAssertTrue(sut.presenter!.interactor?.presenter === sut.presenter!)
    }

    
}
