//
//  UserManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift

/**
 UserManager class.
 Access to user's data easily and costless.
 Instead of always getting the information from Realm database, we save the user sent by the API here and the DbUser.
 And we only access to realm if the user sent by the API doesn't contain the information I want.
 */


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
  
  /**
   Method of the UserManager class.
   Get the first name of the user
   
   @param None.
   
   @return A String contain the first name of the user.
   */
  
  func getUserFirstName() -> String {
    if !networkUser.firstName.isEmpty {
      return networkUser.firstName
    }
    return (localUser[0].firstName.isEmpty) ? "": localUser[0].firstName
  }
  
  /**
   Method of the UserManager class.
   Change the user's first name.
   
   @param String containing the new first name.
   
   @return Nothing.
   */

  func updateUserFirstName(newValue: String) {
    networkUser.firstName = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["firstName":newValue])
  }

  /**
   Method of the UserManager class.
   Get the last name of the user
   
   @param None.
   
   @return A String contain the last name of the user.
   */
  
  func getUserLastName() -> String {
    if !networkUser.lastName.isEmpty {
      return networkUser.lastName
    }
    return (localUser[0].lastName.isEmpty) ? "" : localUser[0].lastName
  }
  
  /**
   Method of the UserManager class.
   Change the user's last name.
   
   @param String containing the new last name.
   
   @return Nothing.
   */
  
  func updateUserLasttName(newValue: String) {
    networkUser.lastName = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["lastName":newValue])
  }
  
  /**
   Method of the UserManager class.
   Get the last name and the first name of the user
   
   @param None.
   
   @return A String contain the last name and the first name of the user.
   */
  
  func getUserCompleteName() -> String {
    if !networkUser.lastName.isEmpty && !networkUser.firstName.isEmpty {
      return networkUser.firstName + " " + networkUser.lastName
    }
    return localUser[0].firstName + " " + localUser[0].lastName
  }
  
  /**
   Method of the UserManager class.
   Get the e-mail of the user
   
   @param None.
   
   @return A String contain the e-mail of the user.
   */
  
  func getUserEmail() -> String {
    if !networkUser.email.isEmpty {
      return networkUser.email
    }
    return (localUser[0].email.isEmpty) ? "" : localUser[0].email
  }
  
  /**
  Method of the UserManager class.
  Change the user's Email.
  
  @param String containing the new Email.
  
  @return Nothing.
  */
  
  func updateUserEmail(newValue: String) {
    networkUser.email = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["email":newValue])
  }
  
  /**
   Method of the UserManager class.
   Get the age of the user
   
   @param None.
   
   @return A String contain the age of the user.
   */
  
  func getUserAge() -> String {
    if !networkUser.age.isEmpty {
      return networkUser.age
    }
    return localUser[0].age
  }
  
  /**
   Method of the UserManager class.
   Get the nickname of the user
   
   @param None.
   
   @return A String contain the nickname of the user.
   */

  func getUserNickname() -> String {
    if !networkUser.nickname.isEmpty {
      return networkUser.nickname
    }
    return (localUser[0].nickname.isEmpty) ? "" : localUser[0].nickname
  }
  
  /**
  Method of the UserManager class.
  Change the user's nickname.
  
  @param String containing the new nickname.
  
  @return Nothing.
  */

  func updateUserNickName(newValue: String) {
    networkUser.nickname = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["nickName":newValue])
  }
  
  /**
   Method of the UserManager class.
   Change the user's age.
   
   @param String containing the new age.
   
   @return Nothing.
   */
  
  func updateUserAge(newValue: String) {
    networkUser.age = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["age":newValue])
  }
  
  /**
   Method of the UserManager class.
   Get the user's living city
   
   @param None.
   
   @return A String containing the user's living city.
   */

  func getUserCity() -> String {
    if !networkUser.city.isEmpty {
      return networkUser.city
    }
    return localUser[0].city
  }
  
  /**
   Method of the UserManager class.
   Change the user's living city.
   
   @param String containing the new city.
   
   @return Nothing.
   */
  
  func updateUserCity(newValue: String) {
    networkUser.city = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["city":newValue])
  }
  
  /**
   Method of the UserManager class.
   Get the gender of the user
   
   @param None.
   
   @return A Gender value containing the gender of the user.
   */

  func getUserGender() -> Gender {
    return networkUser.gender
  }

  /**
   Method of the UserManager class.
   Get the user consommation preferences of the user
   
   @param None.
   
   @return An array of string containing the consommations preferences of the user.
   */

  func getUserConsommationPreferences() -> Array<String> {
    if networkUser.preferences.consoLiked.isEmpty == false {
      return networkUser.preferences.consoLiked
    }
    return localUser[0].preferences.consoLiked
  }
  
  /**
   Method of the UserManager class.
   Get the user etablishment preferences of the user
   
   @param None.
   
   @return An array of string containing the etablishment preferences of the user.
   */
  
  func getUserEtablishmentsPreferences() -> Array<String> {
    if networkUser.preferences.etablishmentLiked.isEmpty == false {
      return networkUser.preferences.etablishmentLiked
    }
    return localUser[0].preferences.etablishmentLiked
  }
  
  /**
   Method of the UserManager class.
   Add consommation to user preferences.
   
   @param String containing the new conso.
   
   @return Nothing.
   */
  
  func addConsommationToUserPreferences(conso: String) {
    networkUser.preferences.consoLiked.append(conso)
    log.debug("Consommation: \(conso) - successfully added")
  }
  
  /**
   Method of the UserManager class.
   Remove a user consommation from his preferences.
   
   @param String containing the consommation to remove.
   
   @return Nothing.
   */
  
  func removeConsommationFromuserPreferences(conso: String) {
    var index = 0
    for value in networkUser.preferences.consoLiked where conso == value {
      networkUser.preferences.consoLiked.remove(at: index)
      index += 1
      log.debug("Consommation: \(conso) - successfully remove")
    }
  }
  
  /**
   Method of the UserManager class.
   Add a new etablishment to user preferences.
   
   @param String containing the etablishment to add.
   
   @return Nothing.
   */
  
  func addEtablishmentToUserPreferences(etablishment: String) {
    networkUser.preferences.etablishmentLiked.append(etablishment)
    log.debug("Etablishment: \(etablishment) - successfully added")
  }
  
  /**
   Method of the UserManager class.
   remove an etablishment from user preferences.
   
   @param String containing the etablishment to remove.
   
   @return Nothing.
   */
  
  func removeEtablishmentFromUserPreferences(etablishment: String) {
    var index = 0
    for value in networkUser.preferences.etablishmentLiked where etablishment == value {
      networkUser.preferences.consoLiked.remove(at: index)
      index += 1
      log.debug("Etablishment: \(etablishment) - successfully remove")
    }
  }
  
  /**
   Method of the UserManager class.
   Update user preferences in database.
   
   @param None.
   
   @return Nothing.
   */
  
  func updateUserPreferencesInDatabase() {
    log.debug(networkUser.preferences.toString())
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["consos":networkUser.preferences.consoLiked])
    log.debug(localUser[0].toString())
  }
  
}