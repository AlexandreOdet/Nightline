//
//  TokenWrapper.swift
//  Nightline
//
//  Created by Odet Alexandre on 16/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import KeychainSwift

class TokenWrapper {
  let keychain = KeychainSwift()
  
  func setToken(valueFor token: String) {
    keychain.set(token, forKey: "token")
  }
  
  func setToken(valueFor token: String, key: String) {
    keychain.set(token, forKey: key)
  }
  
  func getToken() -> String? {
    guard let token = keychain.get("token") else {
      return nil
    }
    return token
  }
  
  func getToken(for key: String) -> String? {
    guard let token = keychain.get(key) else {
      return nil
    }
    return token
  }
  
  func deleteToken() {
    keychain.delete("token")
  }
  
  func deleteToken(for key: String) {
    keychain.delete(key)
  }
  
}
