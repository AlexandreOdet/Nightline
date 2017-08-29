//
//  MenuList.swift
//  Nightline
//
//  Created by Odet Alexandre on 28/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class MenuList: Mappable {
  var menus: [Menu] = []
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    menus <- map["menu"]
  }
}
