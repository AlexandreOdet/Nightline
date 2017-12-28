//
//  RAInvitations.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import PromiseKit

class RAInvitations: RABase {

  enum responseServer {
    case success
    case failure(Error)
  }
  
  func inviteFriend(userId: String, friendId: String, callback: @escaping (responseServer) -> ()) {
    let url = RoutesAPI.baseUrl + AppConstant.Network.user + "/\(userId)/friends/\(friendId)/invite"
    Alamofire.request(url).responseJSON(completionHandler: {
      response in
      switch response.result {
      case .failure(let error):
        callback(.failure(error))
      case .success(_):
        callback(.success)
      }
    })
  }
  
  func acceptUserInvitation(invitationID: String, callback: @escaping (responseServer) -> ()) {
    let url = RoutesAPI.baseUrl + "/invitations/users/\(invitationID)/accept"
    Alamofire.request(url).responseJSON(completionHandler: {
      response in
      switch response.result {
      case .failure(let error):
        callback(.failure(error))
      case .success(_):
        callback(.success)
      }
    })
  }
  
  func declineUserInvitation(invitationID: String, callback: @escaping (responseServer) -> ()) {
    let url = RoutesAPI.baseUrl + "/invitations/users/\(invitationID)/decline"
    Alamofire.request(url).responseJSON(completionHandler: {
      response in
      switch response.result {
      case .failure(let error):
        callback(.failure(error))
      case .success(_):
        callback(.success)
      }
    })
  }
  
  func getUserInvitations(userID: String) -> Promise<InvitationsList> {
    let url = RoutesAPI.baseUrl + AppConstant.Network.user + "/\(userID)/invitations/users"
    return Promise { fulfill, reject in
      self.request = Alamofire.request(url).responseObject(completionHandler: {
        (response: DataResponse<InvitationsList>) in
        switch response.result {
        case .failure(let error):
          reject(error)
        case .success(let invitations):
          fulfill(invitations)
        }
      })
    }
  }
  
  func acceptGroupInvitation(invitationID: String) {
    
  }
  
  func declineGroupInvitation(invitationID: String) {
    
  }
  
  func getUserGroupsInvitation(userID: String) {
    
  }
}
