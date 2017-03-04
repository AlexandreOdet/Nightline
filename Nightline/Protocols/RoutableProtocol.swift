//
//  RoutableProtocol.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/*
 Protocol: RoutableProtocol
 Contains all variables that are useful for the API communication.
 Now contains the url property in read-only
 */

protocol RoutableProtocol {
  var url: String { get }
}
