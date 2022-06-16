//
//  UserItem+CoreDataProperties.swift
//  Project1
//
//  Created by admin on 6/5/22.
//
//

import Foundation
import CoreData


extension UserItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserItem> {
        return NSFetchRequest<UserItem>(entityName: "UserItem")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}

extension UserItem : Identifiable {

}
