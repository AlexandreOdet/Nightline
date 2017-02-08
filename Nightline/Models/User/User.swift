//
//  User.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

class User {
  
  var firstName = ""
  var lastName = ""
  var email = ""
  var nickname = ""
  var passwd = ""
  var id = 0
  
  required init() {
    
  }
  
  init(otherUser: DbUser) {
    self.firstName = otherUser.firstName
    self.lastName = otherUser.lastName
    self.email = otherUser.email
    self.passwd = otherUser.passwd
    self.nickname = otherUser.nickname
    self.id = otherUser.id
  }
}
