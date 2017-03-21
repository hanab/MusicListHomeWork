# MusicListHomeWork
##Songs List
##Introduction
The application shows a list of 100 songs and plays them when the song is clicked. It also shows a list of recently played songs. 

<img src="http://hanabelete.com/ScreenShot.png" width="350" height="500">

## FrameWorkes Used

### UIKit

 * UITableView
 * Custom UITableViewCell (With UIImageView and two UILables)
 * UITextView...

### Alamofire

Used to fetech image data from Url asynchronously
Image data were first saved locally and loaded from the Bundle, but assuming extendablity the image files were loaded using NSUrlSession class (the commented code for this functionalities and the loacally saved files are still in the project), Finally since Alamofire can do the same thing using fewer lines of code , It was chosen to load the image data. The Alamofire was loaded in the project using cocoapod.

### CoreData

Coredata was used to save the songs played persistently. And they are displayed in a tableview.

###  AVFoundation

AVFoundation class was used to play songs which are stored locally in the project.

### XCTest

XCTest class was used to write small unit tests for some of the functions in the project.

## Further Development

The exercise can be improved by loading music files from the network and adding more functionalities.

