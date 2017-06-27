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
  
  func getEtablishmentList() -> Promise<[Etablissement]> {
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(RoutesAPI.etablishment.url).responseArray(completionHandler: {
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
  
  func getEtablishmentProfile(idEtablishment: String) -> Promise<Etablissement> {
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(RoutesAPI.etablishment.url.appending(idEtablishment)).responseObject(completionHandler: {
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
