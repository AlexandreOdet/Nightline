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
    
  func getEtablishmentList() -> Promise<EstablishmentList> {
    return Promise { (fulfill, reject) in
        self.request = Alamofire.request(RoutesAPI.etablishment.url, method: .get, headers: headers).responseObject(completionHandler: {
        (response: DataResponse<EstablishmentList>) in
        switch response.result {
        case .success(let array):
          fulfill(array)
        case .failure(let err):
          reject(err)
        }
      })
    }
  }
  
  func getEtablishmentProfile(idEtablishment: Int) -> Promise<EstablishmentResponse> {
    let url = RoutesAPI.etablishment.url.appending("/" + String(idEtablishment))
    return Promise { (fulfill, reject) in
        self.request = Alamofire.request(url, headers: headers).responseObject(completionHandler: {
        (response: DataResponse<EstablishmentResponse>) in
        switch response.result {
        case .success(let etablishment):
          fulfill(etablishment)
        case .failure(let err):
          reject(err)
        }
      })
    }
  }
  
  func getEstablishmentMenus(idEstablishment: String) -> Promise<MenuList> {
    let url = RoutesAPI.etablishment.url.appending("/\(idEstablishment)/menu")
    return Promise { (fulfill, reject) in
        self.request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        .responseObject(completionHandler: { (response: DataResponse<MenuList>) in
          switch response.result {
          case .success(let menus):
            fulfill(menus)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
  
  func getEstablishmentMenu(idEstablishment: String, idMenu: String) -> Promise<Menu> {
    var parameters = ["EstabID": idEstablishment]
    parameters["MenuID"] = idMenu
    let url = RoutesAPI.etablishment.url.appending("/\(idEstablishment)/menu/\(idMenu)")
    return Promise { (fulfill, reject) in
        self.request = Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseObject(completionHandler: { (response: DataResponse<Menu>) in
          switch response.result {
          case .success(let menu):
            fulfill(menu)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
  
  func getEstablishmentParties(idEstablishment: String) -> Promise<PartyResult> {
    let url = RoutesAPI.etablishment.url.appending("/\(idEstablishment)/soiree")
    return Promise { (fulfill, reject) in
        self.request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        .responseObject(completionHandler: { (response: DataResponse<PartyResult>) in
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

    func searchEstablishment(query: String) -> Promise<SearchResult> {
        let parameters = ["q":query]
        let url = RoutesAPI.baseUrl.appending("/search/establishments")
        return Promise { (fulfill, reject) in
            self.request = Alamofire.request(url, method: .get, parameters: parameters, headers: headers)
                .responseObject(completionHandler: { (response: DataResponse<SearchResult>) in
                    switch response.result {
                    case .success(let results):
                        fulfill(results)
                    case .failure(let error):
                        log.error("\(error)")
                        reject(error) 
                    } 
                })
        }
    }
}
