//
//  Extensions.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension of UIViewController class.
 
 Add hideKeyboardWhenTappedAround method to hide the keyboard when user clicks outside of the UITextField.
 
 @param No param needed.
 
 @return Nothing.
 */

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

