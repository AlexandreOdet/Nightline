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
    let parameters = ["Current user ID":idUser]
    let url = RoutesAPI.party.url.appending("/\(idSoiree)/join")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
  
  
  func leaveParty(idSoiree: String, party: PartyPreview,
                  callbackError: @escaping (String) -> ()) {
    let params = ["SoireeLeavBody":party.toJSONString()!]
    let url = RoutesAPI.party.url.appending("/\(idSoiree)/leave")
    request = Alamofire.request(url, method: .post, parameters: params)
      .responseJSON(completionHandler: { (response: DataResponse<Any>) in
        switch response.result {
        case .success(_):
          return
        case .failure(let error):
          callbackError(error.localizedDescription)
        }
      })
  }
  
  func orderInParty(idSoiree: String, order: OrderParty) -> Promise<Order> {
    let params = ["SoireeOrderBody":order.toJSONString()!]
    let url = RoutesAPI.party.url.appending("/\(idSoiree)/order")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
        .responseObject(completionHandler: { (response: DataResponse<Order>) in
          switch response.result {
          case .success(let order):
            fulfill(order)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
}
