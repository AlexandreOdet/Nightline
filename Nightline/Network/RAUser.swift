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
  func loginUser(email: String, password: String) -> Promise<LoginSignUpUserResponse> {
    let user = User()
    user.email = email
    user.passwd = password
    let parameters = ["user": user.toJSON()]
    let url = RoutesAPI.login.url
    print("URL = \(url)", "\nparameters: \(parameters)")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: {
          (response: DataResponse<LoginSignUpUserResponse>) in
          print(response.result.isSuccess)
          switch response.result {
          case .success(let resp):
            fulfill(resp)
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
  
  func signUpUser(email: String, nickname: String, password: String) -> Promise<LoginSignUpUserResponse> {
    let user = User()
    user.email = email
    user.passwd = password
    let parameters = ["user":user.toJSON()]
    let url = RoutesAPI.signUp.url
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: {
          (response: DataResponse<LoginSignUpUserResponse>) in
          print("Response = ", response)
          switch response.result {
          case .success(let resp):
            fulfill(resp)
          case .failure(let error):
            log.error("RestApiUser.signUp Fail : \(error)")
            reject(error)
          }
        })
    }
  }
  
  
  func loginFB(accessToken: String, userID: String) -> Promise<LoginSignUpUserResponse> {
    let parameters = ["token": accessToken, "userID":userID]
    let url = RoutesAPI.oauth_login.url
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: { (response: DataResponse<LoginSignUpUserResponse>) in
          switch response.result {
          case .success(let resp):
            fulfill(resp)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
  
  func updateUserInfos(id: String) -> Promise<User> {
    let parameters = ["UserID":id]
    let url = RoutesAPI.user.url.appending("/\(id)")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: { (response: DataResponse<User>) in
          switch response.result {
          case .success(let user):
            fulfill(user)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
  
  func getUserInfos(id: String) -> Promise<User> {
    let parameters = ["UserID":id]
    let url = RoutesAPI.user.url.appending("/\(id)")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default)
        .responseObject(completionHandler: { (response: DataResponse<User>) in
          switch response.result {
          case .success(let user):
            fulfill(user)
          case .failure(let error):
            log.error("\(error)")
            reject(error)
          }
        })
    }
  }
  
  func getUserAchievementsList(id: String) -> Promise<[Success]> {
    let parameters = ["UserID":id]
    let url = RoutesAPI.user.url.appending("/\(id)/success")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default)
        .responseArray(completionHandler: { (response: DataResponse<[Success]>) in
          switch response.result {
          case .success(let array):
            fulfill(array)
          case .failure(let err):
            log.error("\(err)")
            reject(err)
          }
        })
    }
  }
  
  func addAchievementToList(idUser: String, success: Success) -> Promise<[Success]> {
    var parameters = ["UserID":idUser]
    parameters["Success"] = success.toJSONString()
    let url = RoutesAPI.user.url.appending("/\(idUser)/success")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseArray(completionHandler: { (response: DataResponse<[Success]>) in
          switch response.result {
          case .success(let array):
            fulfill(array)
          case .failure(let err):
            log.error("\(err)")
            reject(err)
          }
        })
    }
  }
  
  func getUserPreferences(id: String) -> Promise<[Preferences]> {
    let parameters = ["UserID":id]
    let url = RoutesAPI.user.url.appending("/\(id)/preferences")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default)
        .responseArray(completionHandler: { (response: DataResponse<[Preferences]>) in
          switch response.result {
          case .success(let prefs):
            fulfill(prefs)
          case .failure(let err):
            log.error("\(err)")
            reject(err)
          }
        })
    }
  }
  
  func addPreferencesToList(idUser: String, preference: Preferences) -> Promise<[Preferences]> {
    var parameters = ["UserID":idUser]
    parameters["preference"] = preference.toJSONString()
    let url = RoutesAPI.user.url.appending("/\(idUser)/preferences")
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseArray(completionHandler: { (response: DataResponse<[Preferences]>) in
          switch response.result {
          case .success(let prefs):
            fulfill(prefs)
          case .failure(let err):
            log.error("\(err)")
            reject(err)
          }
        })
    }
  }
  
  func searchUser(query: String) -> Promise<SearchResult> {
//    let parameters = ["q": query]
//    let url = RoutesAPI.user.url.appending("/search")
    let url = "https://api.nightline.fr/search/users?q=\(query)"
    return Promise { (fulfill, reject) in
      self.request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
        .responseObject(completionHandler: { (response: DataResponse<SearchResult>) in
          switch response.result {
          case .success(let results):
            fulfill(results)
          case .failure(let err):
            log.error("\(err)")
            reject(err)
          }
        })
    }
  }
}
