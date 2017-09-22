//
//  UITextFieldExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension of UITextField class.
 Add highlightBottom() method to underline the bottom of a UITextField.
 
 @param No param needed.
 
 @return Nothing
 */

extension UITextField {
    func highlightBottom() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(hex: AppConstant.UI.Colors.colorAccent).cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - 1, width:  frame.size.width, height: width)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    
    /**
     Extension of UITextField class.
     Add styleEditTextField() method to defines a number of options commons to all UITextField used in the project.
     
     @param No param needed.
     
     @return Nothing.
     */
    func styleEditField() {
        self.textAlignment = .center
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 5.0
        self.textAlignment = .center
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
