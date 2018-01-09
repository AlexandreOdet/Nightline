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
import ObjectMapper

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
      log.error("WebSocketDidDisconnect With Error : \(err)")
    } else {
      log.error("WebSocket.DidDisconnect")
    }
  }
  
  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    log.debug("WebSocketDidReceiveMessage: \(text)")
    let json = text.toDictionary()
    let notification = NotificationManager.manager.buildNotification(from: json)
    
    log.debug("notification.type = \(notification.type)")
    switch notification.type {
    case "success":
      log.debug("Received Success")
      let successName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez de débloquer le succès \(successName)", duration: .long)
      snackbar.icon = R.image.trophy()
      snackbar.show()
    case "group_invitation":
      log.debug("Receive Group Invitation")
      let groupName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez d'être invité dans le groupe \(groupName) !", duration: .long)
      snackbar.show()
    case "user_invitation":
      log.debug("Receive User Invitation")
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a demandé en ami !", duration: .long)
      snackbar.show()
    case "user_invitation_answered":
      log.debug("Invitation Answered")
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a accepté en tant qu'ami !", duration: .long)
      snackbar.show()
    case "group_invitation_answered":
      log.debug("GroupInvitation Answered")
      let userID = notification.body["userID"] as! Int
      firstly {
        RAUser().getUserInfos(id: "\(userID)")
        }.then { user -> Void in
          DispatchQueue.main.async {
            let groupName = notification.body["name"] as! String
            let snackbar = TTGSnackbar(message: "\(user.user.nickname) a accepté votre invitation au groupe \(groupName)", duration: .long)
            snackbar.show()
          }
        }.catch { _ in
          return
      }
    case "message_received":
      let snackBar = TTGSnackbar(message: "Tu as reçu un nouveau message !", duration: .long,
                                 actionText: "Voir", actionBlock: {
                                  snackbar in
                                  if let userId = notification.body["userID"] as? Int {
                                    firstly {
                                      RAUser().getUserInfos(id: "\(userId)")
                                      }.then { response -> Void in
                                        let user = response.user
                                        let nextViewController = DetailUserViewController()
                                        nextViewController.user = user
                                        DispatchQueue.main.async {
                                          self.navigationController?.pushViewController(nextViewController, animated: true)
                                        }
                                    }
                                  }
      })
      snackBar.show()
     
    case "order_progress":
      log.debug("ORDER PROGRESS")
      if let stepRawValue = notification.body["step"] as? String {
        let step = PaymentStep(step: stepRawValue)
        switch step {
        case .issued:
          ()
        case .confirmed:
          if let orderObject = notification.body["order"] as? [String:Any] {
            let id = orderObject["id"] as! Int
            var price = orderObject["price"] as! Int
            price /= 100
              let alert = UIAlertController(title: "Commande \(id)", message: "Acceptez-vous le paiement de \(price) €", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Accepter", style: .default, handler: {
                _ in
                firstly {
                RAPayment().answerOrderRequest(orderID: id,
                                               userID: UserManager.instance.retrieveUserId(), answer: true)
                  }.then {
                    _ -> Void in
                  }.catch { error in
                    log.error("Error: \(error)")
                }
              }))
              alert.addAction(UIAlertAction(title: "Refuser", style: .destructive, handler: {
                _ in
                firstly {
                RAPayment().answerOrderRequest(orderID: id,
                                               userID: UserManager.instance.retrieveUserId(), answer: false)
                  }.then { _ -> Void in
                  }.catch { error in
                    log.error("Error: \(error)")
                }
              }))
              self.present(alert, animated: true, completion: nil)
          }
        case .ready:
          log.debug("Order Ready") //To-Do UI
        case .delivered:
          log.debug("Order Delivered") //To-Do UI
        default:()
        }
      }
    default:
      ()
    }
  }
  
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    guard let brutJson = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
    guard let properJSON = brutJson as? [String:Any] else { return }
    
    let notification = NotificationManager.manager.buildNotification(from: properJSON)

    switch notification.type {
    case "success":
      let successName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez de débloquer le succès \(successName)", duration: .short)
      snackbar.show()
    case "group_invitation":
      let groupName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "Vous venez d'être invité dans le groupe \(groupName) !", duration: .short)
      snackbar.show()
    case "user_invitation":
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a demandé en ami !", duration: .short)
      snackbar.show()
    case "user_invitation_answered":
      let userName = notification.body["name"] as! String
      let snackbar = TTGSnackbar(message: "\(userName) vous a accepté en tant qu'ami !", duration: .short)
      snackbar.show()
    case "group_invitation_answered":
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
    case "order_progress":
      if let stepRawValue = notification.body["Step"] as? String {
        let step = PaymentStep(step: stepRawValue)
        switch step {
        case .issued:
          ()
        case .confirmed:
          if let orderObject = notification.body["Order"] as? String {
            if let order = Mapper<OrderResponse>().map(JSONString: orderObject) {
              let alert = UIAlertController(title: "Commande \(order.id)", message: "Acceptez-vous le paiement de \(order.price)€", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Accepter", style: .default, handler: {
                _ in
                RAPayment().answerOrderRequest(orderID: order.id,
                                               userID: UserManager.instance.retrieveUserId(), answer: true)
              }))
              alert.addAction(UIAlertAction(title: "Refuser", style: .destructive, handler: {
                _ in
                RAPayment().answerOrderRequest(orderID: order.id,
                                               userID: UserManager.instance.retrieveUserId(), answer: false)
              }))
              self.present(alert, animated: true, completion: nil)
            }
          }
        default:()
        }
      }
    default:
      ()
    }
  }
}
