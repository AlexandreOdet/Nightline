//
//  GroupResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 12/10/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class GroupResponse: Mappable {
  var id: Int!
  var name: String!
  var isPrivate: Bool!
  var users: [User]?
  var owner: Owner!
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    isPrivate <- map["private"]
    users <- map["users"]
    owner <- map["owner"]
  }
}

/*

 "owner": {
 "id": 174,
 "email": "tesst@tesst.com",
 "pseudo": "",
 "password": "tesst",
 "birthdate": "0001-01-01T00:00:00Z"
 }
 */
