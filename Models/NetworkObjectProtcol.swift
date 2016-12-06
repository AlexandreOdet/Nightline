//
//  AModel.swift
//  Nightline
//
//  Created by Odet Alexandre on 24/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation

protocol IModel {
  func isEqual(other: IModel) -> Bool
  func constructor(other: IModel)
  func constructor(other: IDbModel)
 }

class User: IModel {
  var id: Int = 0
  var name: String = ""
  
  internal func isEqual(other: IModel) -> Bool {
    if let obj = other as? User {
      var isEqual:Bool = true
      
      if self.id != obj.id {
        isEqual = false
      }
      
      if self.name != obj.name {
        isEqual = false
      }
      return isEqual
    }
    return false
  }
  
  internal func constructor(other: User) {
    self.id = other.id
    self.name = other.name
  }
  
  internal func constructor(other: IDbModel) {
    if let obj = other as? DbUser {
      
    }
  }
  
}

