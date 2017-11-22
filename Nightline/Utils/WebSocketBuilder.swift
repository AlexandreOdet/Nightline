//
//  WebSocketBuilder.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

class WebsocketBuilder {
  public class func buildMessageWebsocketBody(message: [String:Any]) -> [String:Any] {
    var content = [String:Any]()
    content["type"] = "message"
    content["body"] = message
    return content
  }
  
  public class func buildPaymentWebsocketBody() -> [String:Any] {
    return [String:Any]()
  }
  
  public func buildInvitationSenderWebsocketBody(invitation: [String:Any]) -> [String:Any] {
    var content = [String:Any]()
    content["type"] = ""
    content["body"] = invitation
    return content
  }
}

/*
 {
 "type": "", //enum
 "body": {} // modèle qui change selon le type
 }
 
 ebsockets pour paiement, succès (Juste le succès),
 messagerie (Récupération historique, nouveaux messages),
 invitations (Envoi, acceptation)
 
 */
