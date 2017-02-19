//
//  ExtensionEtablishments.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

extension Etablishment: ModelsProtocol {
  func toString() -> String {
    switch self {
    case .bar:
      return R.string.localizable.bar()
    case .pub:
      return R.string.localizable.pub()
    case .lounge:
      return R.string.localizable.lounge()
    case .club:
      return R.string.localizable.club()
    default:
      return ""
    }
  }
}
