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
    let subscribeAchievement = Achievement(image: image1, title: "Félicitations !", points: 100, description: "Félicitations ! Vous venez de vous inscrire sur Nightline, voici vos 100 premiers points CADEAUX !")
    achievementArray.append(subscribeAchievement)
    
    let img2 = UIImageView(image: R.image.moneyBag())
    let orderAch = Achievement(image: img2, title: "1ère commande !", points: 50, description: "Tu viens de passer ta première commande avec l'application !")
    achievementArray.append(orderAch)
    
    let img3 = UIImageView(image: R.image.lemonade())
    let softAch = Achievement(image: img3, title: "100 Softs Drinks", points: 25, description: "Tu viens de commander ta 100ème boisson non-alcoolisée... Passe aux choses sérieuses un peu ;)")
    achievementArray.append(softAch)
  }
}
