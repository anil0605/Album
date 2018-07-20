//
//  Router.Swift
//  AppRouter
//
//  Created by Anil Kothari on 18/07/18.
//  Copyright © 2018 Miral. All rights reserved.
//

import UIKit

class AppRouter {
    
    private static let mainStoryBoardFileName = "Main"

    // MARK: Main storyboard
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard (name: AppRouter.mainStoryBoardFileName, bundle: Bundle.main)
    }
    

    // MARK: Album Tour View Controller
    static var albumListViewController: AlbumViewController {
        let albumListScreen = AppRouter.mainStoryboard.instantiateViewController(withIdentifier: AlbumViewController.className) as! AlbumViewController
        AppRouter.assembleAlbumScreen(vc: albumListScreen)
        return albumListScreen
    }

    // MARK: Assemble welcome tour module components
    static func assembleAlbumScreen(vc: AlbumViewController) {
        AlbumWireFrame.assembleAlbumModule(vc)
    }

   
}
