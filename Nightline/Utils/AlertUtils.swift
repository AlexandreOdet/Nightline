//
//  AlertUtils.swift
//  Nightline
//
//  Created by Odet Alexandre on 16/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

final class AlertUtils {
  
  static func networkErrorAlert(fromController: UIViewController) {
    let alert = UIAlertController(title: R.string.localizable.error(),
                                  message: R.string.localizable.error_loading_data(),
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil))
    fromController.present(alert, animated: true, completion: nil)
  }
}
