//
//  MenuResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class MenuResponse: Mappable {
  var menu: Menu!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    menu <- map["menu"]
  }
}
