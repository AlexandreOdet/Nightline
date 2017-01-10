//
//  User.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation


class User {
  dynamic var id = -1
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var gender = ""
  dynamic var email = ""
  dynamic var passwd = ""
  dynamic var nickname = ""
  
  init(otherUser: DbUser) {
    self.id = otherUser.id
    self.firstName = otherUser.firstName
    self.lastName = otherUser.lastName
    self.gender = otherUser.gender
    self.email = otherUser.email
    self.passwd = otherUser.passwd
    self.nickname = otherUser.nickname
  }
  
  init() {
    
  }
}
