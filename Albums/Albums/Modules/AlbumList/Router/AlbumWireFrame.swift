//
//  AlbumWireFrame.swift
//  Module/Album
//
//  Created by Anil Kothari on 11/3/17.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit
// MARK: AlbumWireFrame
/**
 *  AlbumWireFrame is an router class of VIPER architecture
 *  It will assemble the module also it will be responsible for all the routing from photo listing screen to any of the screens.
 */
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
