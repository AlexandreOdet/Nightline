//
//  DatabaseObjectProtocol.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import Realm

protocol IDbModel {
  func constructor(other: IModel)
  func update(obj: IModel)
  func update(obj: IDbModel)
  func create(obj: IModel)
  
}
