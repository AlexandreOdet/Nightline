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

final class RAUser: RABase {
  
  /*
   func loginUser of RAUser.
   REST API call for log the user.
   @param email: user's mail, password: user's password, callback: the closure called when the request succeed, callbackError: the closure called when the request fail.
   @return None
   */
//  func loginUser(email: String, password: String,
//                 callback: @escaping (User) -> (),
//                 callbackError: @escaping () -> ()) {
//    
//    let headers = ["Content-Type":"application/json"]
//    let parameters = ["email":"test@test.com", "password":"test"]
//    let url = RoutesAPI.login.url
//    print("URL = \(url)")
//    self.request = Alamofire.request(url, method: .post, parameters: parameters, headers: headers).response(completionHandler: {response in log.debug("\(response)")})
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
//  }
  
  
  // Fonction de test ( request a la mano )
  
  func loginUser(email: String, password: String,
                 callback: @escaping (User) -> (),
                 callbackError: @escaping () -> ()) {
    let todosEndpoint: String = "https://api.nightline.fr/login"
    guard let todosURL = URL(string: todosEndpoint) else {
      print("Error: cannot create URL")
      return
    }
    var todosUrlRequest = URLRequest(url: todosURL)
    todosUrlRequest.httpMethod = "POST"
    let parameters: [String: Any] = ["email": "test@test.com", "password": "test"]
    let jsonTodo: Data
    do {
      jsonTodo = try JSONSerialization.data(withJSONObject: parameters, options: [])
      todosUrlRequest.httpBody = jsonTodo
    } catch {
      print("Error: cannot create JSON from response")
      return
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: todosUrlRequest) {
      (data, response, error) in
      guard error == nil else {
        print("error calling POST on /login")
        print(error!)
        return
      }
      guard let responseData = data else {
        print("Error: did not receive data")
        return
      }
      
      print("ResponseData is = \(responseData)")
      do {
        print("ReceivedData: \(responseData)")
        guard let response = try JSONSerialization.jsonObject(with: responseData,
                                                              options: []) as? [String: Any] else {
                                                                print("Could not get JSON from responseData as dictionary")
                                                                return
        }
        print("The todo is: " + response.description)
        print("Responses keys = \(response.keys)")
        print("Token = \(response["token"])")
        guard let token = response["token"] else {
          print("Could not get token as string from JSON")
          return
        }
        print("The token is: \(token)")
        let user = User()
        user.email = response["email"] as! String
        user.passwd = response["password"] as! String
        user.token = response["token"] as! String
        callback(user)
        
      } catch  {
        print("error parsing response from POST on /todos")
        callbackError()
        return
      }
    }
    task.resume()
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
    _ = RoutesAPI.signUp.url
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
