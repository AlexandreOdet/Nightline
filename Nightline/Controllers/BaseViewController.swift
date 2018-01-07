//
//  BaseViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import Starscream

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
    print("WebSocket.DidConnect ")
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
  }
  
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    print("Data received : \(data)")
    guard let brutJson = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
    guard let properJSON = brutJson as? [String:Any] else { return }
    let notification = NotificationManager.manager.buildNotification(from: properJSON)
    NotificationManager.manager.didReceiveANotification(notification: notification)
  }
}
