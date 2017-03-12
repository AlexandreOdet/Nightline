//
//  Animation.swift
//  Nightline
//
//  Created by Odet Alexandre on 15/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/*
 Animation class.
 This class contains animations used all over the app.
 */

final class Animation {
  
  /*
   Animation: onClick function
   This function animate the cell click like on Android.
   @param sender, the UIView to animate, backgroundColor: the custom color for the sender when clicked.
   @return None
   */
  
  func onClick(sender: UIView, backgroundColor: UIColor = .lightGray) {
    sender.backgroundColor = backgroundColor
    UIView.animate(withDuration: AppConstant.UI.Animation.onClickDuration) {
      sender.backgroundColor = .white
    }
  }
}