//
//  GroupInvitation.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupInvitation: Mappable {

    var id: Int!
    var from: Group!

    required init?(map: Map) {
        id <- map["id"]
        from <- map["from"]
    }

    func mapping(map: Map) {
        id <- map["id"]
        from <- map["from"]
    }
}
