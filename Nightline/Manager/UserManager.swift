//
//  UserManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import PromiseKit

/**
 UserManager class.
 Access to user's data easily and costless.
 Instead of always getting the information from Realm database, we save the user sent by the API here and the DbUser.
 And we only access to realm if the user sent by the API doesn't contain the information I want.
 */


final class UserManager {
  static let instance = UserManager()
  var networkUser = User()
  
  func retrieveUserId() -> Int {
    if let userId = UserDefaults.standard.string(forKey: "userId") {
      print("[UserManager] Retrieved from userDefaults = \(userId)")
      return Int(userId) ?? -1
    }
    return -1
  }
  
  func loadUserInfos() {
    let idUser = UserManager.instance.retrieveUserId()
    print("[UserManager] idUser = \(idUser)")
    if idUser > -1 {
      firstly {
        RAUser().getUserInfos(id: String(idUser))
        }.then { response -> Void in
          if let user = response.user {
            UserManager.instance.networkUser = user
            print("[UserManager]: User Loaded")
          }
        }.catch { _ in
          return
      }
    }
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
  }
  
  /**
   Method of the UserManager class.
   Change the user's age.
   
   @param String containing the new age.
   
   @return Nothing.
   */
  
  func updateUserAge(newValue: String) {
    networkUser.age = newValue
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
    guard let index = networkUser.preferences.consoLiked.index(of: conso) else { return }
    networkUser.preferences.consoLiked.remove(at: index)
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
    guard let index = networkUser.preferences.etablishmentLiked.index(of: etablishment) else { return }
    networkUser.preferences.etablishmentLiked.remove(at: index)
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
    DispatchQueue.global().async {
      userInstance.updateUserInfos(user: self.networkUser)
    }
  }
}
