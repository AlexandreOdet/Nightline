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
    notifications.append(notification)
  }
  
  func didReadANotification(notification: NightlineNotification) -> NotificationDirection {
    switch notification.type {
    case "invitation":
      let invit = Invitation(from: notification)
      InvitationManager.instance.didReceiveAnInvitation(invitation: invit)
      return .invitationList
    case "achievement":
      return .achievement
    case "message":
      return .chat
    default:
      return .unknown
    }
  }
  
  func clearNotifications() {
    notifications.removeAll()
  }
  
}
