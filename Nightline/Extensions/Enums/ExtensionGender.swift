//
//  ExtensionGender.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
/**
 Extension of Gender enum.
 Conforms to isImageable protocol.
 Add a specific image for each gender available in the enum.
 Add a placeholder image if the user's gender is not setted.
 
 @param No param needed.
 */

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
