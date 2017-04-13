//
//  DatabaseUser.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

/*
 Database/Models DbUser
 This object contains all the user's data available offline.
 */

class DbUser: Object {
  dynamic var id = -1
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var gender = ""
  dynamic var email = ""
  dynamic var passwd = ""
  dynamic var nickname = ""
  dynamic var age = ""
  dynamic var city = ""
  dynamic var picture: NSData? = UIImageJPEGRepresentation(R.image.logo()!, 0.1)! as NSData
  var preferences = UserPreferences()
  
  /*
   primaryKey() function.
   This function is defined in the Object protocol.
   It specifies to realm what is the primary key of our object.
   @param: None
   @return the name of the field which stores the primary key.
   */
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  /*
   func areUserIdOk().
   This function is temporary to simulate a connection.
   @param: nickname: user's nickname, passwd: user's password.
   @return True if it's OK, False otherwise
   */
  
  func areUserIdOk(nickname: String, passwd: String) -> Bool {
    return nickname == self.nickname && passwd == self.passwd
  }
}
