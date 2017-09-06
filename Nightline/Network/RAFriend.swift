//
//  RAFriend.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import PromiseKit

class RAFriends: RABase {
  
  func getUserFriendsList(userId: String) -> Promise<FriendsList> {
    let url = RoutesAPI.user.url.appending("/\(userId)/friends")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url).responseObject(completionHandler: {
        (response: DataResponse<FriendsList>) in
        switch response.result {
        case .success(let list):
          fulfill(list)
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
  
  func sendInvitationToUser(userId: String, friendId: String, callbackError: @escaping () -> ()) {
    let url = RoutesAPI.user.url.appending("/\(userId)/\(friendId)/invite")
    request = Alamofire.request(url).responseJSON(completionHandler: {
      (response: DataResponse<Any>) in
      switch response.result {
      case .success(_):
        return
      case .failure(_):
        callbackError()
      }
    })
  }
  
  func getUserInvitationList(userId: String) -> Promise<InvitationsList> {
    let url = RoutesAPI.user.url.appending("/\(userId)/invitations")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url).responseObject(completionHandler: {
        (response: DataResponse<InvitationsList>) in
        switch response.result {
        case .success(let list):
          fulfill(list)
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
  
  func acceptInvitation(userId: String, invitationId: String, callbackError: @escaping () -> ()) {
    let url = RoutesAPI.user.url.appending("/\(userId)/invitations/\(invitationId)/accept")
    request = Alamofire.request(url).responseJSON(completionHandler: {
      (response: DataResponse<Any>) in
      switch response.result {
      case .success(_):
        return
      case .failure(_):
        callbackError()
      }
    })
  }
  
  func declineInvitation(userId: String, invitationId: String, callbackError: @escaping () -> ()) {
    let url = RoutesAPI.user.url.appending("/\(userId)/invitations/\(invitationId)/decline")
    request = Alamofire.request(url).responseJSON(completionHandler: {
      (response: DataResponse<Any>) in
      switch response.result {
      case .success(_):
        return
      case .failure(_):
        callbackError()
      }
    })
  }
}
