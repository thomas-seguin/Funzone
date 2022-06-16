//
//  NoteItem+CoreDataProperties.swift
//  Project1
//
//  Created by admin on 6/5/22.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension NoteItem : Identifiable {

}
