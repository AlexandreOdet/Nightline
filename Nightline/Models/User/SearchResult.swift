//
//  SearchResult.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResult: Mappable {
  
  var count: Int!
  var result: [UserPreview]!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    count <- map["Count"]
    result <- map["Results"]
  }
}
