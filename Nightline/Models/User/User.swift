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
  
  var firstName = ""
  var lastName = ""
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
    firstName = otherUser.firstName
    lastName = otherUser.lastName
    email = otherUser.email
    passwd = otherUser.passwd
    nickname = otherUser.nickname
    city = otherUser.city
    age = otherUser.age
    picture = otherUser.picture
    achievements = otherUser.achievements
    achievementPoints = otherUser.achievementPoints
  }
  
  required init?(map: Map) {
    id <- map["id"]
    email <- map["email"]
    passwd <- map["password"]
    nickname <- map["pseudo"]
    firstName <- map["firstname"]
    nickname <- map["surname"]
    number <- map["number"]
    urlImage <- map["image"]
    success <- map["success_points"]
    friends <- map["connected_to"]
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    email <- map["email"]
    passwd <- map["password"]
    nickname <- map["pseudo"]
    firstName <- map["firstname"]
    nickname <- map["surname"]
    number <- map["number"]
    urlImage <- map["image"]
    success <- map["success_points"]
    friends <- map["connected_to"]
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

