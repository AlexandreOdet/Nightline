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
  
  var hasFilterActivated: Bool = false
  var groupFilterArray = Array<GroupType>()
  var eventFilterArray = Array<EventType>()
  var personFilterArray = Array<PersonType>()
  var etablishmentFilterArray = Array<Etablishment>()
  
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
   Add a new Etablishment to parameters.
   
   @param The Etablishment you need to add.
   
   @return Nothing.
   */
  
  func add(etablishmentType: Etablishment) {
    self.etablishmentFilterArray.append(etablishmentType)
  }
  
  /**
   Method of the MapFilterManager class.
   Remove a groupType from parameters.
   
   @param The GroupType you need to remove.
   
   @return Nothing.
   */
  
  func remove(groupeType: GroupType) {}
  
  /**
   Method of the MapFilterManager class.
   Remove a EventType from parameters.
   
   @param The EventType you need to remove.
   
   @return Nothing.
   */
  
  func remove(eventType: EventType) {}
  
  /**
   Method of the MapFilterManager class.
   Remove a PersonType from parameters.
   
   @param The PersonType you need to remove.
   
   @return Nothing.
   */
  
  func remove(personType: PersonType) {}
  
  /**
   Method of the MapFilterManager class.
   Remove an Etablishment from parameters.
   
   @param The Etablishment you need to remove.
   
   @return Nothing.
   */
  
  func remove(etablishmentType: Etablishment) {}
  
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
    parameters["etabl"] = formatArrayToParametersString(array: self.etablishmentFilterArray)
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
  
  /**
   Method of the MapFilterManager class.
   Format the Array<Etablishment> values to specific string output.
   
   @param The array that needs to be formatted (Array<Etablishment>).
   
   @return Formatted String.
   */

  
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
