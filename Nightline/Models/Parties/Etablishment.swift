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
  
  var id = ""
  var name = ""
  var latitude: Double = 0
  var longitude: Double = 0
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    self.id <- map["id"]
    self.name <- map["name"]
    self.latitude <- map["lat"]
    self.longitude <- map["long"]
  }
}
