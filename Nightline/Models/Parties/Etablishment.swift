//
//  Etablishment.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/06/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Etablissement: Mappable {
  
  var id = 0
  var name = ""
  var latitude: Float = 0
  var longitude: Float = 0
  var description: String = ""
  var imgUrl: String = ""
  var type: Int = -1
  var adress = ""
  var owner: Owner!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    adress <- map["address"]
    latitude <- map["lat"]
    longitude <- map["long"]
    type <- map["type"]
    description <- map["desc"]
    owner <- map["owner"]
  }
}
