//
//  AModel.swift
//  Nightline
//
//  Created by Odet Alexandre on 24/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation

protocol IModel {
  associatedtype T
  func isEqual(other: T) -> Bool
  static func== (this: Self, other: T) -> Bool
  func constructor(other: T)
 }

class User: IModel {
  typealias T = User
  var id: Int = 0
  var name: String = ""
  
  internal func constructor(other: User) {
    self.id = other.id
    self.name = other.name
  }

  static internal func ==(this: User, other: User) -> Bool {
    var isEqual:Bool = true
    
    if this.id != other.id {
      isEqual = false
    }
    
    if this.name != other.name {
      isEqual = false
    }
    return isEqual
  }

  internal func isEqual(other: User) -> Bool {
    var isEqual:Bool = true
    
    if self.id != other.id {
      isEqual = false
    }
    
    if self.name != other.name {
      isEqual = false
    }
    return isEqual
  }
}
