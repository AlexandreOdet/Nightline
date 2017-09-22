//
//  Marker.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import MapKit

/*
 Models: Marker
 This is the custom Marker that is going to be used on the main map.
 */

class Marker: NSObject, MKAnnotation {
  var name: String?
  var locationName: String
  var discipline: String
  var coordinate: CLLocationCoordinate2D
  var id: Int
  
  init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, id: Int) {
    name = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.id = id
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
  
  var title: String? {
    return self.name
  }
}
