//
//  Basket.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Basket {
  
  var users = [User]()
  var consommations = [Consommable]()
  
  init() {}
  
  func splitPrice() -> Float {
    var totalPrice: Float = 0
    for conso in consommations {
      totalPrice += conso.price ?? 0
    }
    return totalPrice / Float(users.count)
  }
  
  func addConsommableToBasket(consommable: Consommable) {
    consommations.append(consommable)
  }
  
  func addUserToBasket(user: User) {
    if !users.contains(where: { $0.id == user.id }) {
      users.append(user)
    }
  }
  
  func userRefusePayment(user: User) {
    
  }
  
  func cancelBasket() {
    users.removeAll()
    consommations.removeAll()
  }
  
  func removeUserFromBasket(user: User) {
    users = users.filter({ $0.id != user.id })
  }
  
  func removeConsommableFromBasket(conso: Consommable) {
  }
  
  func getPrintableBasket() {
    
  }
}
