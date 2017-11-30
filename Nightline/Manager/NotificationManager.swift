//
//  NotificationManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 30/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

class NotificationManager {
  
  var notifications = [NightlineNotification]()
  
  private init() { }
  
  func didReceiveANotification(notification: NightlineNotification) {
    
  }
  
  func didReadANotification(notification: NightlineNotification /*, completionHandler: (()->())? = nil*/) -> NotificationDirection {
    
    var returnValue: NotificationDirection!
    
    switch notification.type {
    case "invitation":
      returnValue = .invitationList
    case "achievement":
      returnValue = .achievement
    case "message":
      return .chat
    default:
      return .unknown
    }
//    if let handler = completionHandler {
//      handler()
//    }
    return returnValue
  }
  
  func clearNotifications() {
    notifications.removeAll()
  }
  
}
