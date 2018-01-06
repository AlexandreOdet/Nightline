//
//  InvitationInformationSenderReceiver.swift
//  Nightline
//
//  Created by Odet Alexandre on 06/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class InvitationInformationSenderReceiver: Mappable {
  
  var id: Int = 0
  var email: String = ""
  var pseudo: String = ""
  var birthdate = ""
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    email <- map["email"]
    pseudo <- map["pseudo"]
    birthdate <- map["birthdate"]
  }
  
}


/*
 "from": {
 "id": 290,
 "email": "tata@toto.com",
 "pseudo": "",
 "password": "tata",
 "birthdate": "Jan 1, 0001 at 12:00am (UTC)"

 */
