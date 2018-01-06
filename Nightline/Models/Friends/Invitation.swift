//
//  Invitation.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Invitation: Mappable {
  
  var id: Int!
  var from: InvitationInformationSenderReceiver!
  var to: InvitationInformationSenderReceiver!
  var when: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    from <- map["from"]
    to <- map["to"]
    when <- map["date"]
  }
  
  init() {
    id = 0
    from = ""
    to = ""
    when = ""
  }
  
  func isEqual(to other: Invitation) -> Bool {
    return id == other.id
  }
  
  init(from notification: NightlineNotification) {
    
  }
  
}

/*
 "id": 0,
 "from": "string",
 "to": "string",
 "date": "string"
 */
