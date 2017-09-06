//
//  InvitationsList.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class InvitationsList: Mappable {
  var invitations: [Invitation] = []
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    invitations <- map["invitations"]
  }
}
