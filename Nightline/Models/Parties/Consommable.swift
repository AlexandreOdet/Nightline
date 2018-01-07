//
//  Consommable.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Consommable: Mappable {
  var id: Int! = 0
  var name: String! = ""
  var price: Float? = 0
  var desc: String! = ""
  
  init(name: String, price: Float) {
    self.name = name
    self.price = price
  }
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    price <- map["price"]
    desc <- map["description"]
  }
  
  init() {}
}
