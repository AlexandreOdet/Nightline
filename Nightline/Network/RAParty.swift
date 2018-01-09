//
//  RAParty.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class RAParty: RABase {
  
  func joinParty(idSoiree: String, idUser: String) -> Promise<Party> {
    var parameters = ["userID":idUser]
    parameters["soireeID"] = idSoiree
    let url = RoutesAPI.party.url.appending("/\(idSoiree)/join")
    return Promise { (fulfill, reject) in
        self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseObject(completionHandler: { (response: DataResponse<Party>) in
          switch response.result {
          case .success(let party):
            fulfill(party)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
  
  
  func leaveParty(idSoiree: String, idUser: String,
                  callbackError: @escaping (String) -> ()) {
    
    var parameters = ["userID":idUser]
    parameters["soireeID"] = idSoiree
    
    let url = RoutesAPI.party.url.appending("/\(idSoiree)/leave")
    request = Alamofire.request(url, method: .post, parameters: parameters, headers: headers)
      .responseData(completionHandler: { (response: DataResponse<Data>) in
        switch response.result {
        case .success(_):
          return
        case .failure(let error):
          callbackError(error.localizedDescription)
        }
      })
  }
}
