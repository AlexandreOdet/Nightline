//
//  GroupList.swift
//  Nightline
//
//  Created by Odet Alexandre on 24/10/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupList: Mappable {
    var groups: [GroupPreview] = []
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
       groups <- map["groups"]
    }
}
