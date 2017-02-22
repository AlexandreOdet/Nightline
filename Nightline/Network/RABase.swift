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

class RABase {
  var request: Alamofire.Request?
  
  func cancelRequest() {
    self.request?.cancel()
  }
}
