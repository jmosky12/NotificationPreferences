//
//  NotificationPreferences+CoreDataProperties.swift
//  HitList (RayWenderlich)
//
//  Created by Jake Moskowitz on 9/23/20.
//  Copyright © 2020 Workday, Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension NotificationPreferences {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationPreferences> {
        return NSFetchRequest<NotificationPreferences>(entityName: "NotificationPreferences")
    }

    @NSManaged public var tenantID: String?
    @NSManaged public var notificationsEnabled: Bool

}
