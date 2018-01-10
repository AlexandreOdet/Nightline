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
  
  var isBasketEmpty: Bool = true {
    didSet {
      NotificationCenter.default.post(name: Notification.Name(rawValue: "BasketHasChanged"), object: nil)
    }
  }
  
  private init() {
  }
  
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
    updatePricePerUser()
  }
  
  func updatePricePerUser() {
    for user in order.users {
      user.price = splitPriceBetweenUsers()
    }
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
    updatePricePerUser()
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
    if !order.consos.isEmpty {
      isBasketEmpty = false
    }
    updatePricePerUser()
  }
  
  func removeConsommableFromOrder(consommableID: Int) {
    var index = 0
    for conso in order.consos {
      if conso.consos.id == consommableID {
        conso.amount -= 1
        if conso.amount <= 0 {
          order.consos.remove(at: index)
        }
      }
      index += 1
    }
    if order.consos.isEmpty {
      isBasketEmpty = true
    }
  }
  
  func chooseCurrentParty(partyID: Int) {
    if order.currentParty.id != 0 {
      clearOrder()
    }
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
  
  func clearOrder() {
    order.consos.removeAll()
    order.users.removeAll()
    totalPrice = 0
    isBasketEmpty = true
  }
  
  func splitPriceBetweenUsers() -> Int {
    return totalPrice / order.users.count
  }
  
  func incrementTotalPrice(price: Int) {
    totalPrice += price
    order.price = totalPrice
    updatePricePerUser()
  }
  
  func decrementTotalPrice(price: Int) {
    totalPrice -= price
    order.price = totalPrice
    updatePricePerUser()
  }
  
  func getAmountOfConsommable(consommableID: Int) -> Int {
    for conso in order.consos {
      if conso.consos.id == consommableID {
        return conso.amount
      }
    }
    return -1
  }
  
  func removeAllConsommable(consommableID: Int, price: Int) {
    var index = 0
    var amountOfConso = 0
    for conso in order.consos {
      if conso.consos.id == consommableID {
        amountOfConso = conso.amount
        order.consos.remove(at: index)
      }
      index += 1
    }
    if order.consos.isEmpty {
      isBasketEmpty = true
    }
    let priceOfConsos = price * amountOfConso
    totalPrice -= priceOfConsos
  }
  
  func orderToString() {
    print(order.toJSON())
  }
}
