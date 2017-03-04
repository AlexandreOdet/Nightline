//
//  TokenWrapper.swift
//  Nightline
//
//  Created by Odet Alexandre on 16/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import KeychainSwift

/**
 TokenWrapper class.
 Wrapper of the KeychainSwift pods, that allows developers to set, get, and delete Keychain data easily.
*/

class TokenWrapper {
  
  let keychain = KeychainSwift()
  
  /**
   Method of the TokenWrapper class.
   Save the value of "token" params in Keychain Services.
   
   @param String containing the token which is going to be saved for use in the app.
   
   @return Nothing.
  */
  
  func setToken(valueFor token: String) {
    keychain.set(token, forKey: "token")
  }
  
  /**
   Method of the TokenWrapper class.
   Save the value ("token") for "key" Keychain Services.
   
   @param String containing the token which is going to be saved for use in the app.
   @param String Key corresponding to the key which will be the name of the value you'll access.
   
   @return Nothing.
   */

  func setToken(valueFor token: String, key: String) {
    keychain.set(token, forKey: key)
  }
  
  /**
   Method of the TokenWrapper class.
   Get the value of "token" key in Keychain Services.
   
   @param None.
   
   @return Optional String. Nil if the token is not set, the token otherwise.
   */

  func getToken() -> String? {
    guard let token = keychain.get("token") else {
      return nil
    }
    return token
  }
  
  /**
   Method of the TokenWrapper class.
   Get the value of "key" params in Keychain Services.
   
   @param String containing the key you want to get the data from.
   
   @return Optional String. Nil if the key is not set, the value for key otherwise.
   */
  
  func getToken(for key: String) -> String? {
    guard let token = keychain.get(key) else {
      return nil
    }
    return token
  }
  
  /**
   Method of the TokenWrapper class.
   Delete the value of "token" params in Keychain Services.
   
   @param None.
   
   @return Nothing.
   */

  func deleteToken() {
    keychain.delete("token")
  }

  /**
   Method of the TokenWrapper class.
   Delete the value of "key" params in Keychain Services.
   
   @param String containing the key which you want to delete the data from.
   
   @return Nothing.
   */
  
  func deleteToken(for key: String) {
    keychain.delete(key)
  }
  
}
