//
//  MapFilterManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

class FilterManager {
  static let instance = FilterManager()
  
  var hasFilterActivated: Bool = false
  var groupFilterArray = Array<GroupType>()
  var eventFilterArray = Array<EventType>()
  var personFilterArray = Array<PersonType>()
  var etablishmentFilterArray = Array<Etablishment>()
}
