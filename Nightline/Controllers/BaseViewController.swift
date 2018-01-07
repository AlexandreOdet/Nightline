//
//  BaseViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit
import Starscream
import TTGSnackbar

/*
 Controllers: BaseViewController
 This controller is like an abstract class, all the UIViewControllers use in this project will inherit from it.
 It defines some functions that'll be use often.
 */

class BaseViewController: UIViewController, WebSocketDelegate  {
  
  var img = UIImageView()
  var label = UILabel()
  var button = UIButton()
  var ws = WebSocket(url: URL(string: AppConstant.Network.websocketsBaseUrl + "\(UserManager.instance.retrieveUserId())")!, protocols: [])
  
  deinit {
    ws.disconnect()
    ws.delegate = nil
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ws.connect()
    ws.delegate = self
    view.backgroundColor = UIColor.black
    createNoConnectivityView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  /*
   createNoConnectivityView() func.
   This function creates and sets position of elements shown where there's no internet connectivity.
   @param None
   @return None
   */
  
  func createNoConnectivityView() {
    img = UIImageView(image: UIImage(named: "logo"))
    view.addSubview(img)
    img.snp.makeConstraints { (make) -> Void in
      make.center.equalToSuperview()
    }
    img.translatesAutoresizingMaskIntoConstraints = false
    img.isHidden = true
    view.addSubview(label)
    label.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(img.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(15)
      make.trailing.equalToSuperview().offset(-15)
      make.centerX.equalToSuperview()
    }
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Pas de connexion internet"
    label.textAlignment = .center
    label.isHidden = true
    view.addSubview(button)
    button.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(label.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(15)
      make.trailing.equalToSuperview().offset(-15)
      make.centerX.equalToSuperview()
    }
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Réessayer", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.backgroundColor = UIColor.lightGray
    button.isHidden = true
  }
  
  /*
   showNoConnectivityView() func.
   This function displays the no connectivity screen to current view.
   @param None
   @return None
   */
  
  func showNoConnectivityView() {
    for subview in view.subviews {
      subview.isHidden = true
    }
    view.backgroundColor = UIColor.white
    img.isHidden = false
    label.isHidden = false
    button.isHidden = false
  }
  
  /*
   hideNoConnectivityView() func.
   This function hide the no connectivity screen from current view.
   @param None
   @return None
   */
  
  func hideNoConnectivityView() {
    view.backgroundColor = UIColor.black
    img.isHidden = true
    label.isHidden = true
    button.isHidden = true
  }
  
  func websocketDidConnect(socket: WebSocketClient) {
  }
  
  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    if let err = error {
      print("WebSocket.DidDisconnect with error: \(err)")
    } else {
      print("WebSocket.DidDisconnect")
    }
  }
  
  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    print("Message received : \(text)")
    let json = text.toDictionary()
    let notification = NotificationManager.manager.buildNotification(from: json)
    
    switch notification.type {
    case "success":
      print("Received Success")
      let successName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez de débloquer le succès \(successName)", duration: .short)
      snackbar.show()
    case "group_invitation":
      print("Receive Group Invitation")
      let groupName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez d'être invité dans le groupe \(groupName) !", duration: .short)
      snackbar.show()
    case "user_invitation":
      print("Receive User Invitation")
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a demandé en ami !", duration: .short)
      snackbar.show()
    case "user_invitation_answered":
      print("Invitation Answered")
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a accepté en tant qu'ami !", duration: .short)
      snackbar.show()
    case "group_invitation_answered":
      print("GroupInvitation Answered")
      let userID = notification.body["userID"] as! Int
      firstly {
        RAUser().getUserInfos(id: "\(userID)")
        }.then { user -> Void in
          let groupName = notification.body["name"] as! String
          let snackbar = TTGSnackbar(message: "\(user.user.nickname) a accepté votre invitation au groupe \(groupName)", duration: .short)
          snackbar.show()
        }.catch { _ in
          return
      }
    default:
      ()
    }
  }
  
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    guard let brutJson = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
    guard let properJSON = brutJson as? [String:Any] else { return }
    
    print("ProperJSON = \(properJSON)")
    
    let notification = NotificationManager.manager.buildNotification(from: properJSON)
    
    switch notification.type {
    case "success":
      print("Received Success")
      let successName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez de débloquer le succès \(successName)", duration: .short)
      snackbar.show()
    case "group_invitation":
      print("Receive Group Invitation")
      let groupName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez d'être invité dans le groupe \(groupName) !", duration: .short)
      snackbar.show()
    case "user_invitation":
      print("Receive User Invitation")
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a demandé en ami !", duration: .short)
      snackbar.show()
    case "user_invitation_answered":
      print("Invitation Answered")
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a accepté en tant qu'ami !", duration: .short)
      snackbar.show()
    case "group_invitation_answered":
      print("GroupInvitation Answered")
      let userID = notification.body["userID"] as! Int
      firstly {
        RAUser().getUserInfos(id: "\(userID)")
        }.then { user -> Void in
          let groupName = notification.body["name"] as! String
          let snackbar = TTGSnackbar(message: "\(user.user.nickname) a accepté votre invitation au groupe \(groupName)", duration: .short)
          snackbar.show()
        }.catch { _ in
          return
      }
    default:
      ()
    }
  }
}
