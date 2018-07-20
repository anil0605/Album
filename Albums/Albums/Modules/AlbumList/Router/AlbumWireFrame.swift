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
        let wireFrame = AlbumWireFrame()

        viewController.presenter = presenter
        presenter.view = viewController

        presenter.wireFrame = wireFrame
        presenter.interactor = interactor

        interactor.presenter = presenter
    }
}

extension AlbumWireFrame: AlbumWireFrameProtocol {

    func pushToHomeViewController(sourceController: UIViewController, destinationController: UIViewController) {
        if let navController = sourceController.navigationController {
            navController.pushViewController(destinationController, animated: true)
        }
    }

    func pushFromMenu(menuScreen: UIViewController) {
    }
}
