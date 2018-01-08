//
//  GroupInvitSender.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupInvitSender: Mappable {
    var id: Int!
    var name: String!
    var description: String!


    required init?(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }
}
