//
//  RAEtablissement.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/06/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import PromiseKit

class RAEtablissement: RABase {
  
  var headers = ["":""]
  
  func getEtablishmentList() -> Promise<[Etablissement]> {
    if let token = TokenWrapper().getToken() {
      headers["Authorization"] = token
    }
    print("Token -> ", TokenWrapper().getToken() ?? "empty Token")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(RoutesAPI.etablishment.url, headers: headers).responseArray(completionHandler: {
        (response: DataResponse<[Etablissement]>) in
        switch response.result {
        case .success(let array):
          fulfill(array)
        case .failure(let err):
          reject(err)
        }
      })
      
    }
  }
  
  func getEtablishmentProfile(idEtablishment: Int) -> Promise<Etablissement> {
    let url = RoutesAPI.etablishment.url.appending("/" + String(idEtablishment))
    if let token = TokenWrapper().getToken() {
      headers["Authorization"] = token
    }
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, headers: headers).responseObject(completionHandler: {
        (response: DataResponse<Etablissement>) in
        switch response.result {
        case .success(let etablishment):
          fulfill(etablishment)
        case .failure(let err):
          reject(err)
        }
      })
    }
  }
}
