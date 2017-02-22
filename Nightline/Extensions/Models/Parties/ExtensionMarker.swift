//
//  ExtensionMarker.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

extension Marker: ModelsProtocol {  
  func toString() -> String {
    var ret = "Marker: \n"
    ret += "Name: \(self.title)\n"
    ret += "Description: \(self.locationName)\n"
    ret += "Localisation =  latitude: \(self.coordinate.latitude) longitude: \(self.coordinate.longitude)\n"
    return ret
  }
 
}
