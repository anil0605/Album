//
//  AppDelegate+Extension.swift
//  Albums
//
//  Created by Anil Kothari on 19/07/18.
//  Copyright © 2018 Anil Kothari. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func loadAlbumScreen() -> UIViewController {
        // Load the instance from the storyboard file
        let listingScreen = AppRouter.albumListViewController
        
        //Assemble the view controller with the VIPER architecture
        AppRouter.assembleAlbumScreen(vc: listingScreen)
        
        return listingScreen
    }
}
