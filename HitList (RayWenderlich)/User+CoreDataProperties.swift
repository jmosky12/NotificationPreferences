//
//  User+CoreDataProperties.swift
//  HitList (RayWenderlich)
//
//  Created by Jake Moskowitz on 9/23/20.
//  Copyright © 2020 Workday, Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var baseURL: String?
    @NSManaged public var tenantName: String?
    @NSManaged public var tenantID: String?

}
