//
//  AlertUtils.swift
//  Nightline
//
//  Created by Odet Alexandre on 16/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/*
 Alert Utils Class.
 This class contains function that contains UIAlertController that will be used often in the app.
 */

final class AlertUtils {
  
  /*
   func networkErrorAlert()
   Create an alert when a request failed.
   @param fromController: Controller that sends the request.
   @return None
   */
  static func networkErrorAlert(from controller: UIViewController) {
    let alert = UIAlertController(title: R.string.localizable.error(),
                                  message: R.string.localizable.error_loading_data(),
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil))
    controller.present(alert, animated: true, completion: nil)
  }
}
