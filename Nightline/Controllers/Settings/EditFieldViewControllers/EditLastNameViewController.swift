//
//  EditFirstNameViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 13/04/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift

class EditLastNameViewController: BaseViewController {
  
  let contentView = UIView()
  let editLabel = UILabel()
  let editTextField = UITextField()
  
  func setupView() {
    self.view.addSubview(contentView)
    contentView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
      make.left.right.bottom.equalTo(self.view)
    }
    self.contentView.addSubview(editLabel)
    editLabel.snp.makeConstraints { make in
      make.top.equalTo(contentView).offset(20)
      make.leading.equalTo(contentView).offset(15)
      make.trailing.equalTo(contentView).offset(-15)
      make.height.equalTo(30)
    }
    self.view.backgroundColor = self.getMidnightBlue()
    editLabel.text = "Nom :"
    editLabel.textColor = UIColor.orange
    self.contentView.addSubview(editTextField)
    editTextField.snp.makeConstraints { make in
      make.top.equalTo(editLabel.snp.bottom).offset(20)
      make.leading.equalTo(contentView).offset(15)
      make.trailing.equalTo(contentView).offset(-15)
    }
    editTextField.text = UserManager.instance.getUserLastName()
    editTextField.borderStyle = .roundedRect
    editTextField.backgroundColor = UIColor.init(hex: 0x233157)
    editTextField.textColor = UIColor.init(hex: 0xFF7F40)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    if (editTextField.text != "") {
      UserManager.instance.updateUserLasttName(newValue: editTextField.text!)
    }
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
