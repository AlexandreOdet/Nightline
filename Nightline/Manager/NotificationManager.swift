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
    print("json = \(json)")
    let jsn = JSON(arrayLiteral: json)
    if let type = jsn["name"].string,
        let body = jsn["body"].dictionary {
        notification.type = type
        notification.body = body
    }
    return notification
  }
  
}
