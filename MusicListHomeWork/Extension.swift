//
//  Extension.swift
//  MusicListHomeWork
//
//  Created by Hana  Demas on 05/07/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

// string extension for generating a random string of 200 letters long
extension String {
    
    static func random(length: Int = 200) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.startIndex.advancedBy(Int(randomValue))])"
        }
        
        return randomString
    }
}

//extention for uiimageview to set its image from url
extension UIImageView {
    
    // get the image data from url using NSUrlsession
    func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
            completion(data: NSData(data: data!))
            }.resume()
    }
    
    // set the image of the imageview asynchronosly
    func downloadImage(url:String){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode = UIViewContentMode.ScaleAspectFit
                self.image = UIImage(data: data!)
            }
        }
    }
}

