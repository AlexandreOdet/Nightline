//
//  DatabaseHandler.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

final class DatabaseHandler {
  let realm = try! Realm()
  
  func insertInDatabase<T: Object>(object: T.Type, properties: [String:Any], update: Bool = true) {
    try! self.realm.write {
      self.realm.create(object.self, value: properties ,update: update)
    }
  }
  
  func getObjectArray<T: Object>(ofType: T.Type) -> [T] {
    return Array(self.realm.objects(T.self))
  }
}
