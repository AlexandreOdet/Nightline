//
//  PersonFilter.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Enum for all persons you're looking for on main Map.
 
 -> Nobody: Nobody you know
 
 -> Friend: Party with your friends.
 
 -> FriendLink: Party with your friends friends.
 
*/

enum PersonType: String {
  case nobody = "nobody"
  case friend = "friend"
  case friendLink = "friend_link"
  case unknown = ""

  func getPersonTypeArray() -> [PersonType] {
    var types = Array<PersonType>()
    return types
  }
}
