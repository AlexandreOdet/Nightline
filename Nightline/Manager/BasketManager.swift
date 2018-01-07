//
//  BasketManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation

class Basket {
  
  static let manager = Basket()
  
  var paymentInstance = RAPayment()
  private var order = PartyOrder()
  var orderHistory = [Int]()
  var totalPrice = 0
  
  private init() {}
  
  func addUserToOrder(userID: Int) {
    for user in order.users {
      if let usr = user.user {
        if usr.id == userID {
          return
        }
      }
    }
    let user = User()
    user.id = userID
    
    let partyUser = PartyUser()
    partyUser.user = user
    
    order.users.append(partyUser)
  }
  
  func addConsommableToOrder(consommableID: Int) {
    for conso in order.consos {
      if conso.consos.id == consommableID {
        conso.amount += 1
        return
      }
    }
    let consommableOrder = PartyConsommable()
    consommableOrder.amount = 1
    consommableOrder.consos = Consommable()
    consommableOrder.consos.id = consommableID
    
    order.consos.append(consommableOrder)
  }
  
  func validateOrder() {
    paymentInstance.orderInParty(order: order)
  }
  
  func chooseCurrentParty(partyID: Int) {
    order.currentParty.id = partyID
  }
  
}
