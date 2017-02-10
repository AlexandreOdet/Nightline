//
//  Consommation.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

enum Consommation: String {
  case beer = "beer"
  case vodka = "vodka"
  case whisky = "whisky"
  case rhum = "rhum"
  case bourbon = "bourbon"
  case wine = "wine"
  case champagne = "champagne"
  case cocktail = "cocktail"
  case unknown = ""
  
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
  
  func getAllConsommationTypes() -> [Consommation] {
    var array = Array<Consommation>()
    array.append(Consommation.beer)
    array.append(Consommation.vodka)
    array.append(Consommation.whisky)
    array.append(Consommation.rhum)
    array.append(Consommation.bourbon)
    array.append(Consommation.wine)
    array.append(Consommation.champagne)
    array.append(Consommation.cocktail)
    return array
  }
  
}
