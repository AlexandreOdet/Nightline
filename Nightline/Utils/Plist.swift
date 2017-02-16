//
//  Plist.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

final class Plist {
  
  class Info {
    static func getBuildVersion() -> String {
      return (Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String)!
    }
  }
  
  class Color {
    static func get(colorWithName: String) -> String? {
      let path = Bundle.main.path(forResource: "Colors", ofType: "plist")
      guard let dict = NSDictionary(contentsOfFile: path!) else {
        return nil
      }
      return (dict.object(forKey: colorWithName) as? String)
    }
  }
  
}
