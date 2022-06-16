//
//  MusicItem+CoreDataProperties.swift
//  Project1
//
//  Created by admin on 6/5/22.
//
//

import Foundation
import CoreData


extension MusicItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicItem> {
        return NSFetchRequest<MusicItem>(entityName: "MusicItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var albumName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var imageName: String?
    @NSManaged public var tackName: String?

}

extension MusicItem : Identifiable {

}
