//
//  AppUIConstant.swift
//  Nightline
//
//  Created by Odet Alexandre on 06/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/*
 AppConstant class.
 This class defines all some constants used all over the app.
 */

final class AppConstant {
  
  /*
   Nested class UI.
   Defines all UI Constants
   */
  
  final class UI {
    final class Colors {
      static let colorPrimary = 0x0e1728
      static let colorAccent = 0xe87e07 //Orange
      static let white = 0xececec
      static let purple = 0x9b59b6
      static let midnightBlue = 0x0e1728
    }
    
    /*
     Nested class Dimensions
     Defines all Dimensions constants (for picture, for example...)
     */
    
    final class Dimensions {
      static let formElementsSpacing = CGFloat(25)
      static let thumbnailPictureSize = CGFloat(128)
    }
    
    /*
     Nested class Animation
     Defines all Animation constants (like duration and/or mathematical values)
     */
    
    final class Animation {
      static let onClickDuration = 0.5
    }
  }
  
  /*
   Nested class Network
   Defines all Network constants
   */
  
  final class Network {
    static let baseUrl = "https://api.nightline.fr"
    static let login = "/login"
    static let signup = "/register"
    static let oauth_login = "/oauth_login"
    static let etablishment = "/establishments"
    static let drinks = ""
    static let user = "/users"
  }
}
