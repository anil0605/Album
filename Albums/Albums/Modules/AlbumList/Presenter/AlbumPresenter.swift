//
//  AlbumWireFrame.swift
//  YasMobileSDK
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//


import UIKit

enum CardType {
    case Authentication
    case AppTour
}

// MARK: AlbumTourLayoutPresenter
/**
 *  AlbumTourLayoutPresenter will fetch the raw data with the help of interactor.
 *  It will also convert the raw models in UI data models
 */
class AlbumPresenter: AlbumPresenterProtocol {
    var wireFrame: AlbumWireFrameProtocol?
    weak var view: AlbumViewProtocol?
    var interactor: AlbumTourInteracterInputProtocol?
    private var albumData = [AlbumModel]()

    /// Pass the control to interactor to fetch the data
    func fetchAlbumData() {
        interactor?.fetchAlbumData()
    }
 
    /// Push the user to welcome screen
    func moveToHomeScreen(homeViewController: UIViewController) {
        wireFrame?.pushToHomeViewController(sourceController: view as! AlbumViewController, destinationController: homeViewController)
    }

}

extension AlbumPresenter: AlbumPresenterOutputProtocol {
    func retrievedPhotoList(data: [AlbumModel]) {
        albumData += data
        view?.showPhotos(list: albumData)
    }
    

    ///Will be used for error handling of the api's
    func showAlertMessage(_ message: String) {

    }

    ///Retrieving the information from interactor, convert it into UI objects and sent to the view
    func didRetrieveTourInformation(data: String, domain: String) {

        let list = convertValueInList(data: data, domain: domain)
        view?.showPhotos(list : list)
    }

    func convertValueInList(data: String, domain: String) -> [AlbumModel] {
        return [AlbumModel]()
    }
}
