//
//  UserManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

final class UserManager {
  static let instance = UserManager()
  var localUser = DatabaseHandler().getObjectArray(ofType: DbUser.self)
  var networkUser = User()
  
  private init() {
    self.initUsers()
  }
  
  func initUsers() {
    networkUser = User(otherUser: localUser[0])
  }
  
  func getUserFirstName() -> String {
    if !networkUser.firstName.isEmpty {
      return networkUser.firstName
    }
    return localUser[0].firstName
  }
  
  func updateUserFirstName(newValue: String) {
    networkUser.firstName = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["firstName":newValue])
  }
  
  func getUserLastName() -> String {
    if !networkUser.lastName.isEmpty {
      return networkUser.lastName
    }
    return localUser[0].lastName
  }
  
  func updateUserLasttName(newValue: String) {
    networkUser.lastName = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["lastName":newValue])
  }
  
  func getUserCompleteName() -> String {
    if !networkUser.lastName.isEmpty && !networkUser.firstName.isEmpty {
      return networkUser.firstName + " " + networkUser.lastName
    }
    return localUser[0].firstName + " " + localUser[0].lastName
  }
  
  func getUserEmail() -> String {
    if !networkUser.email.isEmpty {
      return networkUser.email
    }
    return localUser[0].email
  }
  
  func updateUserEmail(newValue: String) {
    networkUser.email = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["email":newValue])
  }
  
  func getUserAge() -> String {
    if !networkUser.age.isEmpty {
      return networkUser.age
    }
    return localUser[0].age
  }
  
  func updateUserAge(newValue: String) {
    networkUser.age = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["age":newValue])
  }
  
  func getUserCity() -> String {
    if !networkUser.city.isEmpty {
      return networkUser.city
    }
    return localUser[0].city
  }
  
  func updateUserCity(newValue: String) {
    networkUser.city = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["city":newValue])
  }
  
  func getUserConsommationPreferences() -> Array<String> {
    if networkUser.preferences.consoLiked.isEmpty == false {
      return networkUser.preferences.consoLiked
    }
    return localUser[0].preferences.consoLiked
  }
  
  func getUserEtablishmentsPreferences() -> Array<String> {
    if networkUser.preferences.etablishmentLiked.isEmpty == false {
      return networkUser.preferences.etablishmentLiked
    }
    return localUser[0].preferences.etablishmentLiked
  }
  
  func addConsommationToUserPreferences(conso: String) {
    networkUser.preferences.consoLiked.append(conso)
    log.debug("Consommation: \(conso) - successfully added")
  }
  
  func removeConsommationFromuserPreferences(conso: String) {
    var index = 0
    for value in networkUser.preferences.consoLiked where conso == value {
      networkUser.preferences.consoLiked.remove(at: index)
      index += 1
      log.debug("Consommation: \(conso) - successfully remove")
    }
  }
  
  func addEtablishmentToUserPreferences(etablishment: String) {
    networkUser.preferences.etablishmentLiked.append(etablishment)
    log.debug("Etablishment: \(etablishment) - successfully added")
  }
  
  func removeEtablishmentFromUserPreferences(etablishment: String) {
    var index = 0
    for value in networkUser.preferences.etablishmentLiked where etablishment == value {
      networkUser.preferences.consoLiked.remove(at: index)
      index += 1
      log.debug("Etablishment: \(etablishment) - successfully remove")
    }
  }
  
  func updateUserPreferencesInDatabase() {
    log.debug(networkUser.preferences.toString())
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["consos":networkUser.preferences.consoLiked])
    log.debug(localUser[0].toString())
  }
  
}
