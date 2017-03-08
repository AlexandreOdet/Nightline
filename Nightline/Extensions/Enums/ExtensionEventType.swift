//
//  ExtensionEventType.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Extension of EventType enum.
 Conforms to ModelsProtocol.
 Add toString() method to display user infos in specific output
 
 @param No param needed.
 
 @return a localized string corresponding to current enum value.
 */

extension EventType: ModelsProtocol {
  func toString() -> String {
    switch self {
    case .birthday:
      return "Anniversaire"
    default:
      return "Festival"
    }
  }
}
