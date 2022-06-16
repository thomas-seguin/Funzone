//
//  BookItem+CoreDataProperties.swift
//  Project1
//
//  Created by admin on 6/5/22.
//
//

import Foundation
import CoreData


extension BookItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookItem> {
        return NSFetchRequest<BookItem>(entityName: "BookItem")
    }

    @NSManaged public var coverName: String?
    @NSManaged public var pdfName: String?

}

extension BookItem : Identifiable {

}
