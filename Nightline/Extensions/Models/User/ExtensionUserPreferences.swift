//
//  ExtensionUserPreferences.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

extension UserPreferences: ModelsProtocol {
  func toString() -> String {
    var result = ""
    result += "Preferences : \nConso:\n"
    for conso in self.consoLiked {
      result += conso + "\n"
    }
    result += "--------------------\nEtablissements:\n"
    for etabl in self.etablishmentLiked {
      result += etabl + "\n"
    }
    return result
  }
}
