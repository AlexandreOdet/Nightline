//
//  AchievementManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 25/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class AchievementManager {
  static let instance = AchievementManager()
  var achievementArray = Array<Achievement>()
  
  private init() {
    let image1 = UIImageView(image: R.image.toast())
    let subscribeAchievement = Achievement(image: image1, title: "Profil complété", points: 50, name: "ProfileFullyFilled", description: "Profil rempli à 100%")
    achievementArray.append(subscribeAchievement)
    
    let img2 = UIImageView(image: R.image.moneyBag())
    let orderAch = Achievement(image: img2, title: "Première commande", points: 50, name: "firstCommand", description: "Première commande")
    achievementArray.append(orderAch)
    
    let img3 = UIImageView(image: R.image.lemonade())
    let softAch = Achievement(image: img3, title: "100 soft drink", points: 100, name: "softDrink100", description: "Commander 100 soft drink")
    achievementArray.append(softAch)
  }
  
  func validateAchievement(_ name: String, _ controller: BaseViewController) {
    if let achievement = UserManager.instance.validateAchievement(achievementName: name) {
      let achievementCompletedAlert = UIAlertController(title: achievement.title, message: achievement.description, preferredStyle: .alert)
      achievementCompletedAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
        action in
        print("Hello")
      }))
      controller.present(achievementCompletedAlert, animated: true, completion: nil)
    }
  }
  
  func didUnlockANewAchievements(achievement: Achievement) {
    achievementArray.append(achievement)
  }
  
  func initUserAchievementArray() {
    for elem in achievementArray {
      UserManager.instance.addAchievement(newAchievement: elem)
      print("add new achievement to user : \(elem.title)")
    }
  }
}
