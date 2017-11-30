//
//  InvitationManager.swift
//  Nightline
//
//  Created by Odet Alexandre on 30/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

class InvitationManager {
  var invitations = [Invitation]()
  
  static let instance = InvitationManager()
  
  private init() {}
  
  func didReceiveAnInvitation(invitation: Invitation) {
    
  }
  
  func didAcceptAnInvitation(invitation: Invitation) {
    
  }
  
  func didDeclineAnInvitation(invitation: Invitation) {
    
  }
}
