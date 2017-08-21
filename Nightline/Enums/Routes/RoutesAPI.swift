//
//  RoutesAPI.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/*
 Enum: RoutesApi.
 This enums contains all the routes availables for our API.
 @properties baseUrl: The root of our API.
 */

enum RoutesAPI {
  
  static var baseUrl = AppConstant.Network.baseUrl
  
  case login
  case signUp
  case oauth_login
  case etablishment
  case user
}
