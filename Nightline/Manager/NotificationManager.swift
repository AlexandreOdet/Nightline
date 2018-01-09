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
  static let manager = NotificationManager()
  private init() { }
  
  func buildNotification(from json: [String:Any]) -> NightlineNotification {
    let notification = NightlineNotification()
    log.debug("BuildNotification from json = \(json)")
    notification.type = json["name"] as! String
    notification.body = json["body"] as! [String:Any]
    return notification
  }
  
}
