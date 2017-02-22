//
//  User.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Mappable {
  
  var firstName = ""
  var lastName = ""
  var email = ""
  var nickname = ""
  var passwd = ""
  var city = ""
  var age = ""
  var id = 0
  var preferences = UserPreferences()
  var gender = Gender.male
  
  required init() {
    
  }
  
  init(otherUser: DbUser) {
    self.firstName = otherUser.firstName
    self.lastName = otherUser.lastName
    self.email = otherUser.email
    self.passwd = otherUser.passwd
    self.nickname = otherUser.nickname
    self.city = otherUser.city
    self.age = otherUser.age
    self.id = otherUser.id
  }
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.firstName <- map["firstName"]
  }
  
}

