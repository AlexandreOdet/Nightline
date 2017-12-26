//
//  User.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
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
//    var picture: NSData? = nil
    var image: UIImage?
    var number = ""
    var urlImage = ""
    var success = 0
    var friends = [User]()

    required init() {

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

    static func ==(left: User, right: User) -> Bool {
        if left.firstName == right.firstName,
            left.lastName == right.lastName,
            left.email == right.email,
            left.nickname == right.nickname,
            left.passwd == right.passwd,
            left.city == right.city,
            left.age == right.age,
            left.id == right.id {
            return true }
        return false
    }
}

