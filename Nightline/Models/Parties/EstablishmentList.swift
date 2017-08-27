//
//  EstablishmentList.swift
//  Nightline
//
//  Created by Odet Alexandre on 27/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class EstablishmentList: Mappable {
  var array: [Etablissement]!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    array <- map["establishments"]
  }
}
