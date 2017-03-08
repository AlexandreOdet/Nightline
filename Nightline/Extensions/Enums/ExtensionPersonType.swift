//
//  ExtensionPersonFilter.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
/**
 Extension of PersonType enum.
 Conforms to ModelsProtocol.
 Add toString() method to display user infos in specific output
 
 @param No param needed.
 
 @return a localized string corresponding to current enum value.
 */

extension PersonType: ModelsProtocol {
  func toString() -> String {
    switch self {
    case .friend:
      return "Ami"
    case .friendLink:
      return "Ami d'un ami"
    case .nobody:
      return "Personne que tu connais"
    default:
      return ""
    }
  }
}
