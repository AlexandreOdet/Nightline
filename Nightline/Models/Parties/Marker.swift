//
//  Marker.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import MapKit

class Marker: NSObject, MKAnnotation {
  let name: String?
  let locationName: String
  let discipline: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
    self.name = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
  
  var title: String? {
    return self.name
  }
  
  func toString() -> String {
    var ret = "Marker: \n"
    ret += "Name: \(self.title)\n"
    ret += "Description: \(self.locationName)\n"
    ret += "Localisation =  latitude: \(self.coordinate.latitude) longitude: \(self.coordinate.longitude)\n"
    return ret
  }
}
