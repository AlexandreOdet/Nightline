//
//  Utils.swift
//  Nightline
//
//  Created by Odet Alexandre on 06/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import KeychainSwift

/*
 Utils class
 This class contains some subclasses which functions used all over the app.
 */

final class Utils {
  
  /*
   Network class
   This nested class contains some functions network oriented used all over the app.
   */
  final class Network {
    
    /*
     Utils.Network function.
     Check if a internet and/or connectivity is available.
     @param None
     @return true if internet is available, false otherwise.
     */
    
    static func isInternetAvailable() -> Bool
    {
      var zeroAddress = sockaddr_in()
      zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
      zeroAddress.sin_family = sa_family_t(AF_INET)
      
      let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
          SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
      }
      
      var flags = SCNetworkReachabilityFlags()
      if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
      }
      let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
      let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
      return (isReachable && !needsConnection)
    }
    
    static var forceStayStart: Bool = false

    /*
     Utils.Network function.
     Start the spinner in status bar.
     @param None
     @return None
     */

    static func spinnerStart() {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /*
     Utils.Network function.
     Stop the spinner in status bar.
     @param None
     @return None
     */

    static func spinnerStop() {
      if !self.forceStayStart {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
    }
    
    /*
     Utils.Network function.
     log out the user.
     @param None
     @return None
     */
    
    static func logOutUser() {
      tokenWrapper.deleteToken()
      tokenWrapper.deleteToken(for: "userId")
    }
  }
}
