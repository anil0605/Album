//
//  AlbumWireFrame.swift
//  Module/Album
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

class AlbumWireFrame {

    class func assembleAlbumModule(_ viewController: AlbumViewController) {
        let presenter = AlbumPresenter()
        let interactor = AlbumInteractor()

        viewController.presenter = presenter
        presenter.view = viewController

        presenter.interactor = interactor

        interactor.presenter = presenter
    }
}
