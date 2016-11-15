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
  required func isEqual(other: T) -> Bool
  required static func== (other: T) -> Bool
  required static func !=(other: T) -> Bool
  required static func constructor(other: T)
 }

class AModel: IModel {
  typealias T = AModel
  
  func isEqual(other: AModel) -> Bool {
    return true
  }
  
  func ==(other: AModel) -> Bool {
    return true
  }
  
  func !=(other: AModel) -> Bool {
    return true
  }
  
  func constructor(other: AModel) {
    
  }
  
}

class User: AModel {
  var id: Int = 0
  var name: String = ""
  
  override func isEqual(other: AModel) -> Bool {
    let otherObject = other as? User
    var isEqual:Bool = true
    
    if self.id != otherObject.id {
      isEqual = false
    }
    
    if self.name != otherObject?.name {
      isEqual = false
    }
    return isEqual
  }
  
  override func == (other: AModel) -> Bool {
    return self.isEqual(other)
  }
  
  override func != (other: AModel) -> Bool {
    return self.isEqual(other) == false
  }
  
  override static func constructor(other: AModel) {
    let otherUser = other as? User
    self.id = otherUser.id
    self.name = otherUser.name
  }
}
