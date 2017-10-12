//
//  RAGroup.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit
import AlamofireObjectMapper

class RAGroup: RABase {
  
  func createGroup(groupName: String, groupDescription: String) -> Promise<CreateGroupResponse> {
    let group = Group()
    group.name = groupName
    group.description = groupDescription
    
    var parameters = [String:Any]()
    parameters["ownerId"] = UserManager.instance.retrieveUserId()
    parameters["group"] = group.toJSON()
    
    print(parameters)
    let finalUrl = RoutesAPI.baseUrl.appending(AppConstant.Network.groups)
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(finalUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseObject(completionHandler: {
        (response: DataResponse<CreateGroupResponse>) in
        switch response.result {
        case .success(let group):
          fulfill(group)
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
  
  func updateGroupInfo(groupId: String) { }
  
  func deleteGroup(groupId: String, callbackError: @escaping () -> ()){
    let url = RoutesAPI.baseUrl.appending(AppConstant.Network.groups)
    let parameters = ["GroupID":groupId]
    request = Alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: {
      (response: DataResponse<Any>) -> Void in
      switch response.result {
      case .success(_):
        print("Group deleted")
        return
      case .failure(let error):
        print("deleteGroup: \(error.localizedDescription)")
        callbackError()
      }
    })
  }
  
  func getGroupInformations(groupId: Int) -> Promise<CreateGroupResponse> {
    let url = RoutesAPI.baseUrl + AppConstant.Network.groups + "/\(groupId)"
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url).responseObject(completionHandler: {
        (response: DataResponse<CreateGroupResponse>) in
        switch response.result {
        case .success(let group):
          fulfill(group)
        case .failure(let error):
          reject(error)
        }
      })
      
    }
  }
  
}
