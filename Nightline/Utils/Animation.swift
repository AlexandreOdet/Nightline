//
//  Animation.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

final class Animation {
  
  func onClick(sender: UIView, backgroundColor: UIColor = .lightGray) {
    sender.backgroundColor = backgroundColor
    UIView.animate(withDuration: AppConstant.UI.Animation.onClickDuration) {
      sender.backgroundColor = .white
    }
  }
}
