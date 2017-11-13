//
//  Etablishment.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/06/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Etablissement: Mappable {
  
  var id = 0
  var name = ""
  var latitude: Float = 0
  var longitude: Float = 0
  var description: String = ""
  var imgUrl: String = ""
  var type: Int = -1
  var adress = ""
  var rate: Int = 0
  var owner: Int = 0
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    adress <- map["address"]
    latitude <- map["lat"]
    longitude <- map["long"]
    type <- map["type"]
    description <- map["desc"]
    rate <- map["rate"]
    owner <- map["owner"]
  }
}
/*
 "establishment": {
 "id": 71,
 "name": "Lumières",
 "address": "7 Cour Alphonse Daudet, 72230 Ruaudin",
 "long": 2.3732348,
 "lat": 48.8660245,
 "type": "Rooftop",
 "desc": "Lorem ipsum dolor sit amet, dictas conceptam democritum cu nec, soleat petentium maluisset eam ei, in nec illum elaboraret",
 "rate": 4,
 "owner": 70
 */
