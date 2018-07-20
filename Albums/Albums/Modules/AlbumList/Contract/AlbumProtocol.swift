//
//  AlbumViewProtocol.swift
//  Module/Album
//
//  Created by Anil Kothari on 8/23/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

protocol AlbumWireFrameProtocol {
    func pushFromMenu(menuScreen: UIViewController)
    func pushToHomeViewController(sourceController: UIViewController, destinationController: UIViewController)
}

protocol AlbumPresenterProtocol: class {
    var wireFrame: AlbumWireFrameProtocol? {get set}
    var view: AlbumViewProtocol? {get set}
    var interactor: AlbumTourInteracterInputProtocol? {get set}
    func fetchAlbumData()
}

protocol AlbumViewProtocol: class {
    func showPhotos(list: [AlbumModel])
}

protocol AlbumTourInteracterInputProtocol: class {
    var presenter: AlbumPresenterOutputProtocol? {get set}
    func fetchAlbumData()

}

protocol AlbumPresenterOutputProtocol: class {
    func showAlertMessage(_ message: String)
    func retrievedPhotoList(data: [AlbumModel])
}
