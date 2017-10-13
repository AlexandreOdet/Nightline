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

class EditAgeViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  let contentView = UIView()
  let editLabel = UILabel()
  let agePicker = UIPickerView()
  
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
    self.view.backgroundColor = self.backgroundColor()
    editLabel.text = "Age :"
    editLabel.textColor = self.labelTextColor()
    self.contentView.addSubview(agePicker)
    agePicker.snp.makeConstraints { make in
      make.top.equalTo(editLabel.snp.bottom).offset(20)
      make.right.left.equalTo(self.contentView)
      make.height.equalTo(self.contentView).dividedBy(2)
    }
    self.agePicker.delegate = self
    self.agePicker.dataSource = self
    let myRow : Int = Int(UserManager.instance.getUserAge()) ?? 0
    self.agePicker.selectRow(myRow, inComponent: 0, animated: true)
    self.agePicker.backgroundColor = self.backgroundColor()
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 99
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let str = row.toString()
    return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.init(hex: 0xFF7F40)])
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
    UserManager.instance.updateUserAge(newValue: agePicker.selectedRow(inComponent: 0).toString())
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
