//
//  Utils.swift
//  Nightline
//
//  Created by Odet Alexandre on 06/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class Utils {
  
  class UI {
    static func getPurpleColor() -> UIColor {
      return UIColor(hex: AppConstant.UI.Colors.purple)
    }
    
    static func getPrimaryColor() -> UIColor {
      return UIColor(hex: AppConstant.UI.Colors.colorPrimary)
    }
    
    static func getAccentColor() -> UIColor {
      return UIColor(hex: AppConstant.UI.Colors.colorAccent)
    }
    
    static func getWhiteColor() -> UIColor {
      return UIColor(hex: AppConstant.UI.Colors.white)
    }
  }
  
  class Network {
    static func getEtablishmentUrl() -> String {
      return "some-url"
    }
    
    static func getDrinksByEtablishmentUrl(etablishmentId: Int) -> String {
      return "some-url".appending(String(etablishmentId))
    }
    
    static func getLoginUrl() -> String {
      return "some-url"
    }
    
    static func getSignUpUrl() -> String {
      return "some-url"
    }
    
    static func getUserProfileUrl() -> String {
      return "some-url"
    }
  }
}
