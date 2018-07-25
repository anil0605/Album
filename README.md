# Album

Album is an iOS application completely written in Swift 4.1. It shows the images from unsplash api in both the orientations.On Tapping any image on grid it animates with changing its layout to full screen and visibility has been gradually increased from 0 to 100%. Infinite scroll has been implemented in both the orientations and layout. Image detailed page will show author name, image location and biography of the user. 

- [Features](#features)
- [Requirements](#requirements)
- [Device](#device)


## Features

- Grid / Tabular layout of collection view
- JSON parsing with Codable protocol
- VIPER architecture
- Stub data scheme 
- Unit & UI test cases
- Image cache implementation
- Cell animations


Grid layout is shown to the user when the application launched initially and supports both portrait and landscape orientation. The layout is infinitely scrollable in vertical direction and pulls data & images from the unsplash api. Grid shows two items per row. Total images present on the screen is shown at the top of the screen.
Grid items are tappable and layout is changed to tabular with single item present on the screen. This layout now is horizontal scrollable and it is also infinite scrollable. Also there is a close button to go back to the grid layout. It also maintains the item index present in the tabular layout i.e after tapping the close button the same image which is present on the tabular layout will be displayed in the grid layout as well. Tabular layout also shows the author name, location of the image and biography of the author.

A stub scheme has been created in the application which makes developer's enable to work with the application even though the https://api.unsplash.com/photos/?page=2&client_id={clientid} api is down. Also the following is being written as independent module e.g 

DataOperation : It create a connection to the unsplash api and get the data from the server.

Also there are extensions being written on UIView, UIIImageView and NSObject to reuse the code.
UIIImageView + Extension  : It create the network connection and loads the image on itself when the image data is being received sucessfully.
UIView + Extension : It creates the helper methods for the UIView to fadeIn and fadeOut the view.
NSObject + Extension: It helps in converting the classname to String which is usable in many case like declaring reusable identifier, loading View controller instances from storyboard.

Both Grid and Tabular layouts are also present in the common folder so that other modules in the application can also access it.
 
## Requirements

- iOS 10.0+
- Xcode 8.0+
- Swift 4.1+

## Device

Targeted device of the application is iPhone. Application is supported on all the iPhones.
