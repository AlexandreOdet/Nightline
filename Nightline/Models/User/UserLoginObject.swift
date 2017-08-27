//
//  UserLoginObject.swift
//  Nightline
//
//  Created by Odet Alexandre on 23/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class UserLoginObject: Mappable {
  var id: Int!
  var email: String!
  var pseudo: String!
  var password: String!
  var birthdate: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    email <- map["email"]
    pseudo <- map["pseudo"]
    password <- map["password"]
    birthdate <- map["birthdate"]
  }
}

/*
 "id": 86,
 "email": "alexandre.odet@epitech.eu",
 "pseudo": "alexandre.odet",
 "password": "alexandre.odet",
 "birthdate": "0001-01-01T00:00:00Z"
 */
