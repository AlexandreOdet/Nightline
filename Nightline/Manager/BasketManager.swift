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
  var order = PartyOrder()
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
    partyUser.price = 500
    order.users.append(partyUser)
    order.price = 500
  }
  
  func removeUserFromOrder(userID: Int) {
    var index = 0
    for user in order.users {
      if let usr = user.user {
        if usr.id == userID {
          order.users.remove(at: index)
        }
      }
      index += 1
    }
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

  func chooseCurrentParty(partyID: Int) {
    order.currentParty.id = partyID
  }
  
  func addOrderToHistory(orderID: Int) {
    if orderHistory.contains(orderID) {
      return
    }
    orderHistory.append(orderID)
  }
  
  func removeOrderFromHistory(orderID: Int) {
    var index = 0
    for order in orderHistory {
      if order == orderID {
        orderHistory.remove(at: index)
        return
      }
      index += 1
    }
  }
  
}
