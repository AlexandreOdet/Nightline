//
//  ImageableProtocol.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/*
 Protocol: isImageable.
 This protocol is for all enums and/or models that needs to contains image.
 Properties: image -> is the image for the enum/models value. Read only property
             placeholder -> is the temporary image set if we need to load the image from network. Read only property.
 */

protocol isImageable {
  var image: UIImage { get }
  var placeholder: UIImage { get }
}
