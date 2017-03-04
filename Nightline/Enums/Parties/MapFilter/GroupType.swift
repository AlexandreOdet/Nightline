//
//  GroupType.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Enum: GroupType.
 Enum containing all the possibilities for the GroupType filter available on the map.
 
 -> Friend: Party with your friends.
 
 -> Brotherhood: Party with your brotherhood.
 
 -> Sisterhood: Party with your sisterhood.
 
 */

enum GroupType: String {
  case friend = "friend_group"
  case brotherhood = "brotherhood"
  case sisterhood = "sisterhood"
}
