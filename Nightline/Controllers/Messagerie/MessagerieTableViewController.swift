//
//  MessagerieTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Starscream

class MessagerieTableViewController: BaseViewController {
  
  var tableView: UITableView!
  var textField = UITextField()
  
  var otherUserId: Int? = nil
  
  init(otherUser: Int) {
    super.init(nibName: nil, bundle: nil)
    otherUserId = otherUser
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpWebSocket()
  }
  
  func setUpWebSocket() {
    var json = [String:Any]()
    json["name"] = "get_last_messages"
    var body = [String:Any]()
    body["initiator"] = UserManager.instance.retrieveUserId()
    body["recipient"] = otherUserId ?? 0
    
    json["body"] = body
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: json)
    ws.write(data: data)
  }
  
  func sendMessage(message: String) {
    var json = [String:Any]()
    json["name"] = "new_message"
    var body = [String:Any]()
    body["to"] = otherUserId ?? 0
    body["from"] = UserManager.instance.retrieveUserId()
    body["message"] = message
    
    json["body"] = body
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: json)
    ws.write(data: data)
  }
  
  override func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    
  }
}
