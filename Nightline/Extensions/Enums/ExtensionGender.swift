//
//  ExtensionGender.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

extension Gender: isImageable {
  var placeholder: UIImage {
    return R.image.interrogation()!
  }

  var image: UIImage {
    switch self {
    case .male:
      return R.image.male()!
    default:
      return R.image.female()!
    }
  }
}
