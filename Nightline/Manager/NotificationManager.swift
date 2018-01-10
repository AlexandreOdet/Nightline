//
//  NotificationManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 30/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import SwiftyJSON

class NotificationManager {
  
  var notifications = [NightlineNotification]()
  static let manager = NotificationManager()
  private init() { }
  
  func buildNotification(from json: [String:Any]) -> NightlineNotification {
    let notification = NightlineNotification()
    if let type = json["name"] as? String, let  body = json["body"] as? [String:Any] {
        notification.type = type
        notification.body = body
    } else {
        log.debug("La notif n'a pas pu etre parsé")
    }
    return notification
  }
  
}
