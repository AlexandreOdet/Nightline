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

class RAUser: RABase {
  
  let baseUrl = AppConstant.Network.baseUrl
  
  func loginUser(email: String, password: String,
                 callback: @escaping (User) -> (),
                 callbackError: @escaping () -> ()) {
    
    let parameters = ["email":email, "password":password]
    let url = baseUrl.appending(Utils.Network.getLoginUrl())
    Alamofire.request(url, method: .post, parameters: parameters)
      .responseObject(completionHandler: { (response: DataResponse<User>) in
      switch response.result {
      case .success(let user):
        log.verbose("RestApiUser.login OK \(user)")
        callback(user)
      case .failure(let error):
        callbackError()
        log.error("RestApiUser.login Fail : \(error)")
      }
    })
  }
  
  func signUpUser(email: String, nickname: String, password: String,
                  callback: ()->(),
                  callbackError: ()->()) {
    let parameters = ["email":email, "pseudo":nickname, "password":password]
    let url = baseUrl.appending(Utils.Network.getSignUpUrl())
    
    Alamofire.request(url, method: .post, parameters: parameters).responseObject(completionHandler: {
      (response: DataResponse<User>) in
      switch response.result {
      case .success(let user):
        log.verbose("RestApiUser.signUp OK \(user)")
      case .failure(let error):
        log.error("RestApiUser.signUp Fail : \(error)")
      }
    })
  }
}
