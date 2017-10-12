//
//  CreateGroupResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 12/10/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateGroupResponse: Mappable {
  var group: GroupResponse!
  
  required init?(map: Map) {
  }
  
 func mapping(map: Map) {
    group <- map["group"]
  }
}
