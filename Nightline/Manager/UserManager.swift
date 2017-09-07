//
//  UserManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

/**
 UserManager class.
 Access to user's data easily and costless.
 Instead of always getting the information from Realm database, we save the user sent by the API here and the DbUser.
 And we only access to realm if the user sent by the API doesn't contain the information I want.
 */


final class UserManager {
  static let instance = UserManager()
  var localUser: Array<DbUser>? = nil
  var networkUser = User()
  
  private init() {
    localUser = DatabaseHandler().getObjectArray(ofType: DbUser.self)
    print(localUser)
  }
  
  func initDbUser(userFromApi: User) {
    networkUser = userFromApi
    if let users = localUser {
      if !users.isEmpty {
        for user in users {
          if user.email == userFromApi.email {
            DatabaseHandler().insertInDatabase(object: DbUser.self, properties: userFromApi.toJSON())
          }
        }
      } else {
        DatabaseHandler().insertInDatabase(object: DbUser.self, properties: userFromApi.toJSON())
      }
    } else {
      DatabaseHandler().insertInDatabase(object: DbUser.self, properties: userFromApi.toJSON())
    }
    localUser = DatabaseHandler().getObjectArray(ofType: DbUser.self)
  }
  
  func initDbUser(userFromApi: UserLoginObject) {
    if let users = localUser {
      if !users.isEmpty {
        for user in users {
          if user.email == userFromApi.email {
            DatabaseHandler().insertInDatabase(object: DbUser.self, properties: userFromApi.toJSON())
          }
        }
      } else {
        DatabaseHandler().insertInDatabase(object: DbUser.self, properties: userFromApi.toJSON())
      }
    } else {
      DatabaseHandler().insertInDatabase(object: DbUser.self, properties: userFromApi.toJSON())
      localUser = DatabaseHandler().getObjectArray(ofType: DbUser.self)
    }
  }
  
  
  func retrieveUserId() -> Int {
    return Int(TokenWrapper().getToken(for: "userId") ?? "-1") ?? -1
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return (dbUser.firstName.isEmpty) ? "": dbUser.firstName
      }
    }
    return ""
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return (dbUser.lastName.isEmpty) ? "" : dbUser.lastName
      }
    }
    return ""
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return dbUser.firstName + " " + dbUser.lastName
      }
    }
    return ""
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return (dbUser.email.isEmpty) ? "" : dbUser.email
      }
    }
    return ""
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return dbUser.age
      }
    }
    return ""
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
    if let array = localUser {
      if !array.isEmpty {
        let dbUser = array[0]
        return dbUser.nickname
      }
    }
    return ""
  }
  
  /**
   Method of the UserManager class.
   Change the user's nickname.
   
   @param String containing the new nickname.
   
   @return Nothing.
   */
  
  func updateUserNickName(newValue: String) {
    networkUser.nickname = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["nickname":newValue])
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return dbUser.city
      }
    }
    return ""
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
   Get the user's living city
   
   @param None.
   
   @return A String containing the user's living city.
   */
  
  func getUserPicture() -> NSData? {
    if networkUser.picture != nil {
      return networkUser.picture
    }
    if let array = localUser {
      if !array.isEmpty {
        let dbUser = array[0]
        return dbUser.picture
      }
    }
    return nil
  }
  
  /**
   Method of the UserManager class.
   Change the user's living city.
   
   @param String containing the new city.
   
   @return Nothing.
   */
  
  func updateUserPicture(newValue: NSData) {
    networkUser.picture = newValue
    DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["picture":newValue])
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
    if let users = localUser {
      if !users.isEmpty {
      let dbUser = users[0]
        return dbUser.preferences.consoLiked
      }
    }
    return []
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
    if let users = localUser {
      if !users.isEmpty {
        let dbUser = users[0]
        return dbUser.preferences.etablishmentLiked
      }
    }

    return []
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
    log.debug(localUser?[0].toString() ??  "nil")
  }
  
  /**
   Method of the UserManager class.
   Add an achievement in the user's achievement array if it doesn't exist yet.
   
   @param The achievement to add.
   
   @return Nothing.
   */
  
  func addAchievement(newAchievement: Achievement) {
    for elem in networkUser.achievements {
      if elem.title == newAchievement.title {
        return
      }
    }
    networkUser.achievements.append(newAchievement)
  }
  
  /**
   Method of the UserManager class.
   Used to know if the user already unlocked an achievement or not.
   
   @param The achievement's name.
   
   @return true if the achievement is already unlocked or false in the oposite case.
   */
  
  func getAchievementStatus(_ achievement: String) -> Bool{
    for elem in networkUser.achievements {
      if elem.name == achievement {
        return elem.status.value
      }
    }
    return false
  }
  
  /**
   Method of the UserManager class.
   Change the status of an achievement to unlock.
   
   @param Achievement's name.
   
   @return An Achievement Object or nil.
   */
  
  //  func validateAchievement<T: Achievement>(achievementName: String) -> T? {
  //    for elem in networkUser.achievements {
  //      if elem.name == achievementName && elem.status == .lock {
  //        elem.status = .unlock
  //        networkUser.achievementPoints = networkUser.achievementPoints + elem.points
  //        print("L'achievement : \(achievementName) a bien été validé")
  //        return (elem as! T)
  //      }
  //    }
  //    return nil
  //  }
  
  func validateAchievement(achievementName: String) -> Achievement? {
    for elem in networkUser.achievements {
      if elem.name == achievementName && elem.status == .lock {
        elem.status = .unlock
        networkUser.achievementPoints = networkUser.achievementPoints + elem.points
        print("L'achievement : \(achievementName) a bien été validé")
        return (elem)
      }
    }
    return nil
  }
  
  /**
   Method of the UserManager class.
   Get the achievement score of the user.
   
   @param None.
   
   @return the Achievement score.
   */
  
  func getUserAchievementPoints() -> String {
    return String(networkUser.achievementPoints)
  }
  
  func pushUserUpdate() {
    let userInstance = RAUser()
    let user = User(otherUser: (localUser?[0])!)
    DispatchQueue.global().async {
      userInstance.updateUserInfos(user: user)
    }
  }
}
