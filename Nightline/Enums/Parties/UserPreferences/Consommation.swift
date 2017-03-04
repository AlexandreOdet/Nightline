//
//  Consommation.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Enum: Consommation.
 Enum containing all the possibilities for the consommation preferences.
 */

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
  
  /**
   Function of Consommation Enum.
   Have the array of all consommation type available.
   
   @param: None
   @return An array with all the consommation available.
   */
  
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
