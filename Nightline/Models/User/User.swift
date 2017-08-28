//
//  User.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

/*
 Models: User.
 This is the user models define on both client and API.
 */

class User: Mappable {
  
  var firstName = "FirstName Test"
  var lastName = "LastName Test"
  var email = ""
  var nickname = ""
  var passwd = ""
  var city = ""
  var age = ""
  var id = 0
  var achievements : [Achievement] = []
  var achievementPoints = 0
  var preferences = UserPreferences()
  var gender = Gender.male
  var picture: NSData? = nil
  var number = ""
  var urlImage = ""
  var success = 0
  var friends = [User]()
  
  required init() {
    
  }
  
  /*
   init(otherUser: DbUser)
   This initializer is used when no network is available and we need some data.
   We copy all data stored in Realm in this user.
   */
  
  init(otherUser: DbUser) {
    self.firstName = otherUser.firstName
    self.lastName = otherUser.lastName
    self.email = otherUser.email
    self.passwd = otherUser.passwd
    self.nickname = otherUser.nickname
    self.city = otherUser.city
    self.age = otherUser.age
    self.picture = otherUser.picture
    self.achievements = otherUser.achievements
    self.achievementPoints = otherUser.achievementPoints
  }
  
  required init?(map: Map) {
    self.id <- map["id"]
    self.email <- map["email"]
    self.passwd <- map["password"]
    self.nickname <- map["pseudo"]
    self.firstName <- map["firstname"]
    self.nickname <- map["surname"]
    self.number <- map["number"]
    self.urlImage <- map["image"]
    self.success <- map["success_points"]
    self.friends <- map["connected_to"]
  }
  
  func mapping(map: Map) {
    self.id <- map["id"]
    self.email <- map["email"]
    self.passwd <- map["password"]
    self.nickname <- map["pseudo"]
    self.firstName <- map["firstname"]
    self.nickname <- map["surname"]
    self.number <- map["number"]
    self.urlImage <- map["image"]
    self.success <- map["success_points"]
    self.friends <- map["connected_to"]
  }
  
  /*
   id":89,
   "email":"maxime.guittet@epitech.eu",
   "pseudo":"Emixam23",
   "firstname":"Max",
   "surname":"Guitto",
   "number":"0672887116",
   "image":"https://scontent-cdg2-1.xx.fbcdn.net/v/t1.0-9/20264966_1478159712231945_5607515030047449810_n.jpg?oh=11497f8779f16d018066188a635259a2\u0026oe=5A20CEA6"
   */
  
}

