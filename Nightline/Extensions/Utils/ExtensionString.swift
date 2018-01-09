//
//  ExtensionString.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Extension of String class. Add Length method
 
 @param No param needed
 
 @return number of characters in the string.
 */

extension String {
  func length() -> Int {
    return self.count
  }
  
  func toDictionary() -> [String:Any] {
    if let data = self.data(using: .utf8) {
      do {
        return (try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])!
      } catch {
        log.error(error.localizedDescription)
      }
    }
    return [String:Any]()
  }
}

