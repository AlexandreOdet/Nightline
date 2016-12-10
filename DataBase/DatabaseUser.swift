//
//  DatabaseUser.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

class DbUser: Object {
  dynamic var id = -1
  dynamic var firstName = ""
  dynamic var lastName = ""
  dynamic var gender = ""
  dynamic var email = ""
  dynamic var passwd = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
