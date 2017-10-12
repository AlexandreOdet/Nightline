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
  
  func createGroup(groupName: String, groupDescription: String, id: Int = -1, members: [User]) -> Promise<Group> {
    let group = Group()
    group.name = groupName
    group.description = groupDescription
    group.id = id
    group.users.append(contentsOf: members)
    
    var parameters = [String:Any]()
    parameters["ownerId"] = UserManager.instance.retrieveUserId()
    parameters["group"] = group.toJSON()
    
    let finalUrl = RoutesAPI.baseUrl.appending(AppConstant.Network.groups)
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(finalUrl, parameters: parameters).responseObject(completionHandler: {
        (response: DataResponse<Group>) in
        switch response.result {
        case .success(let group):
          fulfill(group)
        case .failure(let error):
          reject(error)
        }
      })
    }
    
    func updateGroupInfo(groupId: String) { }
    
    func deleteGroup(groupId: String) { }
    
    func getGroupInformations(groupId: String) { }
    
}
