//
//  RAUser.swift
//  Nightline
//
//  Created by Odet Alexandre on 16/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import PromiseKit

/*
 RAUser, subclass of RABase.
 Here all the communications to the API related to the user.
 */

final class RAUser: RABase {
  
  /*
   func loginUser of RAUser.
   REST API call for log the user.
   @param email: user's mail, password: user's password, callback: the closure called when the request succeed, callbackError: the closure called when the request fail.
   @return None
   */
  func loginUser(email: String, password: String) -> Promise<User> {
    
    let parameters = ["email":email, "password":password]
    let url = RoutesAPI.login.url
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: {
          (response: DataResponse<User>) in
          switch response.result {
          case .success(let usr):
            log.verbose("RestApiUser.signUp OK \(usr.toString())")
            fulfill(usr)
          case .failure(let error):
            log.error("RestApiUser.signUp Fail : \(error)")
            reject(error)
          }
        })
    }
  }
  
  
  
  /*
   func signUpUser of RAUser.
   REST API call for signing up the user.
   @param email: user's mail, password: user's password, callback: the closure called when the request succeed, callbackError: the closure called when the request fail.
   @return None
   */
  
  func signUpUser(email: String, nickname: String, password: String) -> Promise<User> {
    let parameters = ["email":"Lol", "pseudo":"Lol", "password":"lol"]
    let url = RoutesAPI.signUp.url
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: {
          (response: DataResponse<User>) in
          switch response.result {
          case .success(let usr):
            log.verbose("RestApiUser.signUp OK \(usr.toString())")
            fulfill(usr)
          case .failure(let error):
            log.error("RestApiUser.signUp Fail : \(error)")
            reject(error)
          }
        })
    }
  }
}
