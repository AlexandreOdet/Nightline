//
//  PersonFilter.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Enum: PersonType.
 Enum containing all the possibilities for the PersonType filter available on the map.
 
 -> Nobody: Nobody you know
 
 -> Friend: Party with your friends.
 
 -> FriendLink: Party with your friends friends.
 
*/

enum PersonType: String {
  case nobody = "nobody"
  case friend = "friend"
  case friendLink = "friend_link"
  case unknown = ""

  /**
   Method of the PersonType enum.
   Get the array of all the PersonType values.
   
   @param None.
   
   @return Array of all the values.
   */
  
  func getPersonTypeArray() -> [PersonType] {
    var types = Array<PersonType>()
    return types
  }
}
