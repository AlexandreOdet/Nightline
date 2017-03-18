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
                 callback: @escaping (Token) -> (),
                 callbackError: @escaping () -> ()) {
    
    let parameters = ["email":email, "password":password]
    let url = RoutesAPI.login.url
    self.request = Alamofire.request(url, method: .post, parameters: parameters)
      .responseObject(completionHandler: { (response: DataResponse<Token>) in
      switch response.result {
      case .success(let token):
        log.verbose("RestApiUser.login OK \(token)")
        callback(token)
      case .failure(let error):
        callbackError()
        log.error("RestApiUser.login Fail : \(error)")
      }
    })
  }

  /*
   func signUpUser of RAUser.
   REST API call for signing up the user.
   @param email: user's mail, password: user's password, callback: the closure called when the request succeed, callbackError: the closure called when the request fail.
   @return None
   */
  
  func signUpUser(email: String, nickname: String, password: String,
                  callback: @escaping (Token)->(),
                  callbackError: @escaping ()->()) {
    let parameters = ["Email":email, "Pseudo":nickname, "Password":password]
    let url = RoutesAPI.signUp.url
    
    self.request = Alamofire.request(url, method: .post, parameters: parameters).responseObject(completionHandler: {
      (response: DataResponse<Token>) in
      switch response.result {
      case .success(let token):
        log.verbose("RestApiUser.signUp OK \(token)")
        callback(token)
      case .failure(let error):
        log.error("RestApiUser.signUp Fail : \(error)")
        callbackError()
      }
    })
  }
}
