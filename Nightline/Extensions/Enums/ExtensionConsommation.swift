//
//  ExtensionConsommation.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

extension Consommation: ModelsProtocol {
  func toString() -> String {
    switch self {
    case .beer:
      return R.string.localizable.beer()
    case .vodka:
      return R.string.localizable.vodka()
    case .whisky:
      return R.string.localizable.whisky()
    case .rhum:
      return R.string.localizable.rhum()
    case .bourbon:
      return R.string.localizable.bourbon()
    case .wine:
      return R.string.localizable.wine()
    case .champagne:
      return R.string.localizable.champagne()
    case .cocktail:
      return R.string.localizable.cocktail()
    default:
      return ""
    }
  }
}
