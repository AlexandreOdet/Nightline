//
//  PaymentStep.swift
//  Nightline
//
//  Created by Odet Alexandre on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation

enum PaymentStep: String {
  case issued = "Issued"
  case confirmed = "Confirmed"
  case verified = "Verified"
  case ready = "Ready"
  case delivered = "Deliverpaid"
  
  case unknown = ""
  
  init(step: String) {
    switch step {
    case "Issued":
      self = .issued
    case "Confirmed":
      self = .confirmed
    case "Verified":
      self = .verified
    case "Ready":
      self = .ready
    case "Deliverpaid":
      self = .delivered
    default:
      self = .unknown
    }
  }
}
