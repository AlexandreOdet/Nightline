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

/*
 RAUser, subclass of RABase.
 Here all the communications to the API related to the user.
 */

class RAUser: RABase {
  
  /*
   func loginUser of RAUser.
   REST API call for log the user.
   @param email: user's mail, password: user's password, callback: the closure called when the request succeed, callbackError: the closure called when the request fail.
   @return None
   */
  func loginUser(email: String, password: String,
                 callback: @escaping (User) -> (),
                 callbackError: @escaping () -> ()) {
    
    let headers = ["Content-Type":"application/json"]
    let parameters = ["email":"test@test.com", "password":"test"]
    let url = RoutesAPI.login.url
    print("URL = \(url)")
    self.request = Alamofire.request(url, method: .post, parameters: parameters, headers: headers).response(completionHandler: {response in log.debug("\(response)")})
//      .responseObject(completionHandler: { (response: DataResponse<User>) in
//      switch response.result {
//      case .success(let token):
//        log.verbose("OK \(token)")
//        callback(token)
//      case .failure(let error):
//        callbackError()
//        log.error("Fail : \(error)")
//      }
//    })
  }

  /*
   func signUpUser of RAUser.
   REST API call for signing up the user.
   @param email: user's mail, password: user's password, callback: the closure called when the request succeed, callbackError: the closure called when the request fail.
   @return None
   */
  
  func signUpUser(email: String, nickname: String, password: String,
                  callback: @escaping (User)->(),
                  callbackError: @escaping ()->()) {
    let parameters = ["email":"Lol", "pseudo":"Lol", "password":"lol"]
    let url = RoutesAPI.signUp.url
    let headers = ["Content-Type":"application/json"]
    self.request = Alamofire.request("https://api.nightline.fr/register", method: .post, parameters: parameters, headers: headers).response(completionHandler: {response in log.debug("\(response)")})

//      .responseObject(completionHandler: {
//      (response: DataResponse<User>) in
//      log.warning("\(response.result)")
//      switch response.result {
//      case .success(let usr):
//        log.verbose("RestApiUser.signUp OK \(usr)")
//        callback(usr)
//      case .failure(let error):
//        log.error("RestApiUser.signUp Fail : \(error)")
//        callbackError()
//      }
//    })
  }
}
