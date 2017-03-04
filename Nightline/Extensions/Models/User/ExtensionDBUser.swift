//
//  ExtensionDBUser.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Extension of DbUser Model.
 Conforms to ModelsProtocol.
 Add toString() method to display user infos in specific output
 
 @param No param needed.
 
 @return a String containing all informations about DbUser instance.
 */


extension DbUser: ModelsProtocol {
  func toString() -> String {
    return ""
  }
}
