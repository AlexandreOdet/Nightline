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

extension BaseViewController {
    func backgroundColor() -> UIColor {
        return UIColor.init(hex: 0x2E1B0A)
    }

    func textFieldBackgroundColor() -> UIColor {
        return UIColor.init(hex: 0x331D0B)
    }

    func textFieldTextColor() -> UIColor {
        return UIColor.init(hex: 0xF08329)
    }

    func labelTextColor() -> UIColor {
        return UIColor.init(hex: 0x9C998C)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    enum Direction {
        case top
        case right
        case bottom
        case left
    }

    func transitionDirection(from: Direction) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = { () -> String in
            switch from {
            case .top:
                return kCATransitionFromTop
            case .right:
                return kCATransitionFromRight
            case .left:
                return kCATransitionFromLeft
            case .bottom:
                return kCATransitionFromBottom
            }
        }()
        if view.window != nil {
            view.window!.layer.add(transition, forKey: kCATransition)
        } else {
            print("Error during transition direction switch")
        }
    }
}

