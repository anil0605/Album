//
//  AlbumsTests.swift
//  AlbumsTests
//
//  Created by Anil Kothari on 22/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import XCTest
@testable import Albums

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
  
    func testStoryboardIsNotNil(){
        let storyboard = AppRouter.mainStoryboard
        XCTAssertNotNil(storyboard)
    }
    
    func testAlbumViewControllerIsNotNil(){
        let storyboard = AppRouter.albumListViewController
        XCTAssertNotNil(storyboard)
    }
    
    //Presentor cannot be nil after assembling of VIPER components
    func testPresenterNotNil() {
        
        XCTAssertNotNil(sut.presenter)
    }
    
    func testVIPERElementsAreNotNil() {
        let presenter = sut.presenter!
        
        // all the presenter VIPER elements should have corresponding componenets
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        
    }
    
    func testPresenterViewIsSystemUnderTest() {
        XCTAssertTrue(sut.presenter!.view === sut)
    }
    
    func testInteractorIsCoupledWithPresenter() {
        XCTAssertTrue(sut.presenter!.interactor?.presenter === sut.presenter!)
    }
    
    
    func testIfDefaultCollectionViewFlowLayoutIsGrid(){
        XCTAssertTrue(sut.collectionView.collectionViewLayout is GridLayout)
    }
    
    func testIfPaginationIsDisabledDefault() {
        XCTAssertTrue(sut.collectionView.isPagingEnabled == false)
    }
    
    
    func testCollectionItemCountAfterFirstCall(){
        let promise = expectation(description: "Data Retrieved successfully")
        XCTAssertTrue(self.sut.dataSource.count == 0)
        
        //Check isFetch is false
        XCTAssertFalse(sut.isFetchingData)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            if self.sut.dataSource.count == 10 {
                promise.fulfill()
            }else{
                XCTFail("Data downloading failed.")
            }
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
}
