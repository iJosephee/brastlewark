//
//  BrastlewarkResponse.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import ObjectMapper

class BrastlewarkResponse: Mappable {
    public var brastlewark: [GnomeResponse]?
    
    required public init?(map: Map) {
        
    }
    
    open func mapping(map: Map) {
        brastlewark <- map["Brastlewark"]
    }
    
}
