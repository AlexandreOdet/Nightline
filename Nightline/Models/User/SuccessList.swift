//
//  SuccessList.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class SuccessList: Mappable {
    var success: [Success] = []

    required init?(map: Map) {
        success <- map["success"]
    }

    func mapping(map: Map) {
        success <- map["success"]
    }
}
