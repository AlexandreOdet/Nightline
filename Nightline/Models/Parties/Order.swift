//
//  Order.swift
//  Nightline
//
//  Created by Odet Alexandre on 23/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Order: Mappable {
  
  var id: Int!
  var price: Float!
  var reference: String!
  var created: String!
  var paid: String!
  var delivered: String!
  var completed: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["ID"]
    price <- map["Price"]
    reference <- map["Reference"]
    created <- map["Created"]
    paid <- map["Paid"]
    delivered <- map["Delivered"]
    completed <- map["Completed"]
  }
}

/*
 {
 "ID": 0,
 "Price": 0,
 "Reference": "string",
 "Created": "string",
 "Paid": "string",
 "Delivered": "string",
 "Completed": "string"
 }
 */
