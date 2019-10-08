//
//  Gnome+CoreDataProperties.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//
//

import Foundation
import CoreData


extension Gnome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gnome> {
        return NSFetchRequest<Gnome>(entityName: "Gnome")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var age: Int32
    @NSManaged public var weight: Double
    @NSManaged public var height: Double
    @NSManaged public var hair_color: String?
    @NSManaged public var professions: [String]?
    @NSManaged public var friends: [String]?

}
