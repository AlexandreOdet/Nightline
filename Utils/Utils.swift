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

class Utils {
  
  class UI {
    
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
  }
}
