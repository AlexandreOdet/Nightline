//
//  ExtensionRoutesAPI.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Extension Routes API enum.
 Conform to RoutableProtocol.
 Defining a specific URL for each value of the enum via the "url" variable.
 
 @param No param needed.
 
 @return URL from `self` value.
 */

extension RoutesAPI: RoutableProtocol {
  var url: String {
    let path: String = {
      switch self {
      case .login:
        return AppConstant.Network.login
      case .signUp:
        return AppConstant.Network.signup
      case .oauth_login:
        return AppConstant.Network.oauth_login
      case .etablishment:
        return AppConstant.Network.etablishment
      case .user:
        return AppConstant.Network.user
      }
    }()
    return (RoutesAPI.baseUrl.appending(path))
  }
}
