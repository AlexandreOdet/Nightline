//
//  ExtensionRoutesAPI.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

extension RoutesAPI: RoutableProtocol {
  var url: String {
    let path: String = {
      switch self {
      case .login:
        return AppConstant.Network.login
      case .signUp:
        return AppConstant.Network.signup
      }
    }()
    return (RoutesAPI.baseUrl.appending(path))
  }
}
