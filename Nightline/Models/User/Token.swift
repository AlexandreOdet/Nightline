//
//  Token.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Token: Mappable {
  
  var value: String = ""
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    self.value <- map["Token"]
  }
}
