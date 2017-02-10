//
//  UserManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

class UserManager {
  static let instance = UserManager()
  var localUser = DatabaseHandler().getObjectArray(ofType: DbUser.self)
  var networkUser = User()
  
  private init() {
    self.initUsers()
  }
  
  func initUsers() {
    networkUser = User(otherUser: localUser[0])
  }
  
  func getUserFirstName() -> String {
    if !networkUser.firstName.isEmpty {
      return networkUser.firstName
    }
    return localUser[0].firstName
  }
  
  func updateUserFirstName(newName: String) {
    networkUser.firstName = newName
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["firstName":newName])
  }
  
  func getUserLastName() -> String {
    if !networkUser.lastName.isEmpty {
      return networkUser.lastName
    }
    return localUser[0].lastName
  }
  
  func getUserEmail() -> String {
    if !networkUser.email.isEmpty {
      return networkUser.email
    }
    return localUser[0].email
  }
}
