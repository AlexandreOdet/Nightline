//
//  AppUIConstant.swift
//  Nightline
//
//  Created by Odet Alexandre on 06/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

final class AppConstant {
  class UI {
    class Colors {
      static let colorPrimary = 0x0e1728
      static let colorAccent = 0xe87e07 //Orange
      static let white = 0xececec
      static let purple = 0x9b59b6
      static let midnightBlue = 0x0e1728
    }
    
    class Dimensions {
      static let formElementsSpacing = CGFloat(25)
      static let thumbnailPictureSize = CGFloat(128)
    }
    
    class Animation {
      static let onClickDuration = 0.5
    }
  }
  
  class Network {
    static let baseUrl = "http://35.16.60.166:8080"
    static let login = ""
    static let signup = ""
    static let etablishment = ""
    static let drinks = ""
  }
}
