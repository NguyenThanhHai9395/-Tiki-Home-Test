//
//  Recent+CoreDataProperties.swift
//  
//
//  Created by ThanhHai on 9/25/18.
//
//

import Foundation
import CoreData


extension Recent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recent> {
        return NSFetchRequest<Recent>(entityName: "Recent")
    }

    @NSManaged public var keyword: String?

}
