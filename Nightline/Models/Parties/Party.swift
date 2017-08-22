//
//  Party.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Party: Mappable {
  var id: Int!
  var description: String!
  var begin: String!
  var end: String!
  var menu: Menu!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["ID"]
    description <- map["Desc"]
    begin <- map["Begin"]
    end <- map["End"]
    menu <- map["Menu"]
  }
}
