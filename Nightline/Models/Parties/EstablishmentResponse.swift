//
//  EstablishmentResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 30/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class EstablishmentResponse: Mappable {
  var establishment: Etablissement!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    establishment <- map["establishment"]
  }
}
