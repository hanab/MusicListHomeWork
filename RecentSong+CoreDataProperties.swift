//
//  RecentSong+CoreDataProperties.swift
//  
//
//  Created by Tehetena Masresha on 09/07/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RecentSong {

    @NSManaged var songTitle: String?
    @NSManaged var bandName: String?
    @NSManaged var songDescription: String?
    @NSManaged var imageUrl: String?
    @NSManaged var songFileName: String?

}
