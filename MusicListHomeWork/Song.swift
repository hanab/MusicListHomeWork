//
//  Song.swift
//  MusicListHomeWork
//
//  Created by Hana  Demas on 02/07/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

struct Song {
    
    //MARK: Properties
    var title:String
    var bandName:String
    var singerPhoto:UIImage?
    var description:String
    var songFileName:String
    var imageUrl:String
    
    //MARK: Init
    init(title:String, bandName:String,singerPhoto:UIImage, description:String, songFileName:String, imageUrl:String) {
        self.title = title
        self.bandName = bandName
        self.singerPhoto = singerPhoto
        self.description = description
        self.songFileName = songFileName
        self.imageUrl = imageUrl
    }
    
    init(title:String, bandName:String, description:String, songFileName:String, imageUrl:String) {
        self.title = title
        self.bandName = bandName
        self.description = description
        self.songFileName = songFileName
        self.imageUrl = imageUrl
    }
    
    //MARK:Methods
    
    // a static method used to get song objects from the json file in the bundle
    static func getSongsFromJson() -> [Song] {
        var songs = [Song]()
        guard let path = NSBundle.mainBundle().pathForResource("songs", ofType: "json"),
            data = NSData(contentsOfFile: path) else {
                return songs
        }
        
        do {
            let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            guard let songObjects = rootObject["songs"] as? [[String: AnyObject]] else {
                return songs
            }
            
            for songObject in songObjects {
                if let title = songObject["title"] as? String,
                    bandName = songObject["bandName"]  as? String,
                    songFileName = songObject["song"] as? String,
                    imageUrl = songObject["imageURL"] as? String {
                    
                    let description = String.random()
                    if let imageName = songObject["image"] as? String,
                        image = UIImage(named:imageName) {
                        let song = Song(title: title, bandName: bandName,singerPhoto: image, description: description, songFileName: songFileName, imageUrl: imageUrl)
                        songs.append(song)
                        
                    } else {
                    
                        let song = Song(title: title, bandName: bandName, description: description, songFileName: songFileName, imageUrl: imageUrl)
                        songs.append(song)
                    }
                }
            }
        } catch {
            return songs
        }
        
        return songs
    }
}