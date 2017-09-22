//
//  LoginSignUpUserResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 28/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginSignUpUserResponse: Mappable {
  var token: String?
  var user: UserLoginObject?
  
  required init?(map: Map) {
    user <- map["user"]
    token <- map["token"]
  }
  
  func mapping(map: Map) {
    user <- map["user"]
    token <- map["token"]
  }
}
