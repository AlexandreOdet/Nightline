//
//  ExtensionMarker.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Extension of Marker Model.
 Conforms to ModelsProtocol.
 Add toString() method to display user infos in specific output
 
 @param No param needed.
 
 @return a String containing all informations about Marker instance.
 */


extension Marker: ModelsProtocol {  
  func toString() -> String {
    var ret = "Marker: \n"
    ret += "Name: \(String(describing: self.title))\n"
    ret += "Description: \(self.locationName)\n"
    ret += "Localisation =  latitude: \(self.coordinate.latitude) longitude: \(self.coordinate.longitude)\n"
    ret += "Id = \(self.id)"
    return ret
  }
 
}
