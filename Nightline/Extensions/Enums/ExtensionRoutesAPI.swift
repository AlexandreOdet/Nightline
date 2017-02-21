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
        return "/login"
      case .signUp:
        return "/signup"
      }
      return ""
    }()
    return (RoutesAPI.baseUrl.appending(path))
  }
}
