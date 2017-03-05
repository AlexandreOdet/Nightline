//
//  DatabaseHandler.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

/*
 DatabaseHandler class.
 This class contains function to handle realms call easily.
 */

final class DatabaseHandler {
  let realm = try! Realm()
  
  /*
   insertInDatabase<T:Object> function.
   This function lets user writes or update a object of type T.
   @param: object: The type of the object, properties: the properties you want to store or update, update: true if you want to update, false if you want to write
   @return None
   */
  
  func insertInDatabase<T: Object>(object: T.Type, properties: [String:Any], update: Bool = true) {
    try! self.realm.write {
      self.realm.create(object.self, value: properties ,update: update)
    }
  }
  
  /*
   getObjectArray<T:Object> function.
   This function return an Array of Object.
   @param: ofType: The type of the object you want to get.
   @return Array of type T.
   */
  
  func getObjectArray<T: Object>(ofType: T.Type) -> [T] {
    return Array(self.realm.objects(T.self))
  }
}
