//
//  Plist.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/*
 Plist class.
 This class contains useful function to get data from a Plist file.
 */

final class Plist {
  final class Info {
    
    /*
     func of Plist.info class
     Get the build version from info.plist file.
     @param None
     @return String containing the build version.
     */
    
    static func getBuildVersion() -> String {
      return (Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String)!
    }
  }
  
  final class Color {
    
    /*
     func of Plist.Color class
     Get a custom color from colors.plist file.
     @param None
     @return String containing the hexadecimal value of the color.
     */
    
    static func get(colorWithName: String) -> String? {
      let path = Bundle.main.path(forResource: "Colors", ofType: "plist")
      guard let dict = NSDictionary(contentsOfFile: path!) else { return nil }
      return (dict.object(forKey: colorWithName) as? String)
    }
  }
  
}
