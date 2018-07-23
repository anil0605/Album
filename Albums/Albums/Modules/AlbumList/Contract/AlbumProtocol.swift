//
//  AlbumViewProtocol.swift
//  Module/Album
//
//  Created by Anil Kothari on 8/23/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

protocol AlbumPresenterProtocol: class {
    var view: AlbumViewProtocol? {get set}
    var interactor: AlbumTourInteracterInputProtocol? {get set}
    func fetchAlbumData()
}

protocol AlbumViewProtocol: class {
    func showPhotos(list: [AlbumModel])
    func showAlertMessage(_ message: String)
}

protocol AlbumTourInteracterInputProtocol: class {
    var presenter: AlbumPresenterOutputProtocol? {get set}
    func fetchAlbumData()
}

protocol AlbumPresenterOutputProtocol: class {
    func showAlertMessage()
    func retrievedPhotoList(data: [AlbumModel])
}
