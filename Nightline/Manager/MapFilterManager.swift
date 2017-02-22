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
  
  func add(groupeType: GroupType) {}
  func add(eventType: EventType) {}
  func add(personType: PersonType) {}
  func add(etablishmentType: Etablishment) {}
  
  func remove(groupeType: GroupType) {}
  func remove(eventType: EventType) {}
  func remove(personType: PersonType) {}
  func remove(etablishmentType: Etablishment) {}
  
  func toParameters() -> [String:String] {
    var parameters = [String:String]()
    parameters["group"] = formatArrayToParametersString(array: self.groupFilterArray)
    parameters["event"] = formatArrayToParametersString(array: self.eventFilterArray)
    parameters["person"] = formatArrayToParametersString(array: self.personFilterArray)
    parameters["etabl"] = formatArrayToParametersString(array: self.etablishmentFilterArray)
    return parameters
  }
  
  private func formatArrayToParametersString(array: Array<GroupType>) -> String {
    var value = ""
    for item in array {
      value += item.rawValue + "|"
    }
    if value.characters.count > 1 {
      value.remove(at: value.index(before: value.endIndex))
    }
    return (value.isEmpty) ? "all" : value
  }
  
  private func formatArrayToParametersString(array: Array<EventType>) -> String {
    var value = ""
    for item in array {
      value += item.rawValue + "|"
    }
    if value.characters.count > 1 {
      value.remove(at: value.index(before: value.endIndex))
    }
    return (value.isEmpty) ? "all" : value
  }
  
  private func formatArrayToParametersString(array: Array<PersonType>) -> String {
    var value = ""
    for item in array {
      value += item.rawValue + "|"
    }
    if value.characters.count > 1 {
      value.remove(at: value.index(before: value.endIndex))
    }
    return (value.isEmpty) ? "all" : value
  }
  
  private func formatArrayToParametersString(array: Array<Etablishment>) -> String {
    var value = ""
    for item in array {
      value += item.rawValue + "|"
    }
    if value.characters.count > 1 {
      value.remove(at: value.index(before: value.endIndex))
    }
    return (value.isEmpty) ? "all" : value
  }
}
