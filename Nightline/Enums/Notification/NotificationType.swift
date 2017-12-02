//
//  NotificationType.swift
//  Nightline
//
//  Created by Odet Alexandre on 02/12/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

enum NotificationType: String {
  case achievement = "achievement"
  case invitation = "invitation"
  case message = "message"
  case unknown = ""
  
  init(type: String) {
    switch type {
    case "achievement":
      self = .achievement
    case "invitation":
      self = .invitation
    case "message":
      self = .message
    default:
      self = .unknown
    }
  }
}
