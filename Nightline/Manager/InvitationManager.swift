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
    if !invitations.contains(where: { $0.id == invitation.id }) {
      invitations.append(invitation)
    }
  }
  
  func didAcceptAnInvitation(invitation: Invitation) {
    //toDo
  }
  
  func didDeclineAnInvitation(invitation: Invitation) {
    //toDo
  }
}
