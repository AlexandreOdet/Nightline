//
//  MapFilterManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 MapFilterManager class
 This class is here to handle how the filters will be send over the API.
*/

final class FilterManager {
  static let instance = FilterManager()
  
  private var groupFilterArray = Array<GroupType>()
  private var eventFilterArray = Array<EventType>()
  private var personFilterArray = Array<PersonType>()
  
  /**
   Method of the MapFilterManager class.
   Add a new groupType to parameters.
   
   @param The GroupType you need to add.
   
   @return Nothing.
   */
  
  func add(groupeType: GroupType) {
    self.groupFilterArray.append(groupeType)
  }

  /**
   Method of the MapFilterManager class.
   Add a new EventType to parameters.
   
   @param The EventType you need to add.
   
   @return Nothing.
   */

  func add(eventType: EventType) {
    self.eventFilterArray.append(eventType)
  }
  
  /**
   Method of the MapFilterManager class.
   Add a new PersonType to parameters.
   
   @param The PersonType you need to add.
   
   @return Nothing.
   */
  
  func add(personType: PersonType) {
    self.personFilterArray.append(personType)
  }
  
  /**
   Method of the MapFilterManager class.
   Remove a groupType from parameters.
   
   @param The GroupType you need to remove.
   
   @return Nothing.
   */
  
  func remove(groupeType: GroupType) {
    if let idx = self.groupFilterArray.index(of: groupeType) {
      groupFilterArray.remove(at: idx)
    }
  }
  
  /**
   Method of the MapFilterManager class.
   Remove a EventType from parameters.
   
   @param The EventType you need to remove.
   
   @return Nothing.
   */
  
  func remove(eventType: EventType) {
    if let idx = self.eventFilterArray.index(of: eventType) {
      eventFilterArray.remove(at: idx)
    }
  }
  
  /**
   Method of the MapFilterManager class.
   Remove a PersonType from parameters.
   
   @param The PersonType you need to remove.
   
   @return Nothing.
   */
  
  func remove(personType: PersonType) {
    if let idx = self.personFilterArray.index(of: personType) {
      personFilterArray.remove(at: idx)
    }
  }
  
  func isItemInArray(groupType: GroupType) -> Bool {
    if self.groupFilterArray.index(of: groupType) != nil {
      return true
    }
    return false
  }
  
  func isItemInArray(eventType: EventType) -> Bool {
    if self.eventFilterArray.index(of: eventType) != nil {
      return true
    }
    return false
  }
  
  func isItemInArray(personType: PersonType) -> Bool {
    if self.personFilterArray.index(of: personType) != nil {
      return true
    }
    return false
  }
  
  /**
   Method of the MapFilterManager class.
   Create a Dictionary of all the filters values.
   
   @param None.
   
   @return Dictionary <String, String> of the parameters.
   */
  
  func toParameters() -> [String:String] {
    var parameters = [String:String]()
    parameters["group"] = formatArrayToParametersString(array: self.groupFilterArray)
    parameters["event"] = formatArrayToParametersString(array: self.eventFilterArray)
    parameters["person"] = formatArrayToParametersString(array: self.personFilterArray)
    return parameters
  }
  
  /**
   Method of the MapFilterManager class.
   Format the Array<GroupType> values to specific string output.
   
   @param The array that needs to be formatted (Array<GroupType>).
   
   @return Formatted String.
   */
  
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
  
  /**
   Method of the MapFilterManager class.
   Format the Array<EventType> values to specific string output.
   
   @param The array that needs to be formatted (Array<EventType>).
   
   @return Formatted String.
   */

  
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
  
  /**
   Method of the MapFilterManager class.
   Format the Array<PersonType> values to specific string output.
   
   @param The array that needs to be formatted (Array<PersonType>).
   
   @return Formatted String.
   */

  
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
}
