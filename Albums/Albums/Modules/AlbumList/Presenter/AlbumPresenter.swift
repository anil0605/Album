//
//  AlbumWireFrame.swift
//  YasMobileSDK
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

// MARK: AlbumTourLayoutPresenter
/**
 *  AlbumTourLayoutPresenter will fetch the raw data with the help of interactor.
 *  It will also convert the raw models in UI data models
 */
class AlbumPresenter: AlbumPresenterProtocol {
    weak var view: AlbumViewProtocol?
    var interactor: AlbumTourInteracterInputProtocol?
    private var albumData = [AlbumModel]()

    /// Pass the control to interactor to fetch the data
    func fetchAlbumData() {
        interactor?.fetchAlbumData()
    }
}

extension AlbumPresenter: AlbumPresenterOutputProtocol {
    func retrievedPhotoList(data: [AlbumModel]) {
        albumData += data
        view?.showPhotos(list: albumData)
    }
    
    ///Error handling of the api's
    func showAlertMessage() {
        let message = "Technical issue. Error in retrieving data."
        view?.showAlertMessage(message)
    }

}
