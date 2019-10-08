//
//  GnomeResponse.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import ObjectMapper

class GnomeResponse: Mappable {
    public var id: Int?
    public var name: String?
    public var thumbnail: String?
    public var age: Int?
    public var weight: Double?
    public var height: Double?
    public var hair_color: String?
    public var professions: [String]?
    public var friends: [String]?
    
    required public init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        thumbnail <- map["thumbnail"]
        age <- map["age"]
        weight <- map["weight"]
        height <- map["height"]
        hair_color <- map["hair_color"]
        professions <- map["professions"]
        friends <- map["friends"]
    }
}
