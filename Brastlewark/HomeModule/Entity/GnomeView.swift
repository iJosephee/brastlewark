//
//  Gnome.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import ObjectMapper

final class GnomeView {
    public var iden: Int?
    public var name: String?
    public var thumbnail: String?
    public var age: Int?
    public var weight: Double?
    public var height: Double?
    public var hair_color: String?
    public var professions: [String]?
    public var friends: [String]?
    
    init(_ iden: Int?, name: String?, thumbnail: String?, age: Int?, weight: Double?, height: Double?, hair_color: String?, professions: [String]?, friends: [String]?) {
        self.iden = iden
        self.name = name
        self.thumbnail = thumbnail
        self.age = age
        self.weight = weight
        self.height = height
        self.hair_color = hair_color
        self.professions = professions
        self.friends = friends
    }
    
}
