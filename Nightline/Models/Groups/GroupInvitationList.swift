//
//  GroupInvitationList.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupInvitationList: Mappable {

    var list = [GroupInvitation]()

    required init?(map: Map) {
        list <- map["invitations"]
    }

    func mapping(map: Map) {
        list <- map["invitations"]
    }
}
