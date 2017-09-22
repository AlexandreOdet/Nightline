//
//  RABase.swift
//  Nightline
//
//  Created by Odet Alexandre on 18/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

/*
  RABase class.
  Here is the base of all the REST API subclasses.
 */

class RABase {
  var request: Alamofire.Request?
  
  /*
   RABase function.
   Cancel a request when living a controller.
   @param: None
   @return: None
   */
  
  func cancelRequest() {
    request?.cancel()
  }
}
