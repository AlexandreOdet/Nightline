//
//  Menu.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Menu: Mappable {
  var id: Int!
  var description: String!
  var name: String!
  var conso: [Consommable]?
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    description <- map["desc"]
    name <- map["name"]
    conso <- map["consos"]
  }
}
