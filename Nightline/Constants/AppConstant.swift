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
      public class var colorPrimary: Int { return 0x0e1728 }
      public class var colorAccent: Int { return 0xe87e07  }//Orange
      public class var white: Int { return 0xececec }
      public class var purple: Int { return 0x9b59b6 }
      public class var midnightBlue: Int { return 0x0e1728 }
    }
    
    /*
     Nested class Dimensions
     Defines all Dimensions constants (for picture, for example...)
     */
    
    final class Dimensions {
      public class var formElementsSpacing: CGFloat { return CGFloat(25) }
      public class var thumbnailPictureSize: CGFloat { return CGFloat(128) }
    }
    
    /*
     Nested class Animation
     Defines all Animation constants (like duration and/or mathematical values)
     */
    
    final class Animation {
      public class var onClickDuration: Double { return 0.5 }
    }
  }
  
  /*
   Nested class Network
   Defines all Network constants
   */
  
  final class Network {
    public class var baseUrl: String { return "https://api.nightline.fr" }
    public class var login: String { return "/login" }
    public class var signup: String { return "/register" }
    public class var oauth_login: String { return "/oauth_login" }
    public class var etablishment: String { return "/establishments" }
    public class var user: String { return "/users" }
    public class  var party: String { return "/soiree" }
    public class var payment: String { return "/update_stripe_user" }
    public class var groups: String { return "/groups" }
    public class var websocketsBaseUrl: String { return "ws://nightline.fr:8048/"}
    public class var order: String { return "/orders" }
  }
  
  final class StripeToken {
    public class var publishableKey: String { return "pk_test_kdowSzKoGipTvU32aHZtryoq" }
  }
}
