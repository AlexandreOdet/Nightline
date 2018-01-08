//
//  Success.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Success: Mappable {

    var id: Int!
    var name: String!
    //  var points: Int!
    var isUnlocked: Bool!
    var value: String!
    //  var icon: String!

    required init?(map: Map) {
        id <- map["id"]
        name <- map["name"]
        //    points <- map["Points"]
        isUnlocked <- map["active"]
        value <- map["value"]
        //    icon <- map["Icon"]
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        //    points <- map["Points"]
        isUnlocked <- map["active"]
        value <- map["value"]
        //    icon <- map["Icon"]
    }
}
