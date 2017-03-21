//
//  RecentSong.swift
//  MusicListHomeWork
//
//  Created by Tehetena Masresha on 09/07/2016.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
import CoreData


class RecentSong: NSManagedObject {

    // attributes saved in coredata
    @NSManaged var songTitle: String
    @NSManaged var bandName: String
    @NSManaged var songDescription: String
    @NSManaged var imageUrl: String
    @NSManaged var songFileName: String
}
