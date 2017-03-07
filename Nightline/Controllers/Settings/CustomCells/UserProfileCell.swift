//
//  UserProfileCell.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/*
 Controllers: UserProfileCell
 Custom Cell for the user's profile, subclass of UITableViewCell.
 */

class UserProfileCell: UITableViewCell {
  
  var type: SettingsCell = .Profile
  var userPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
  var labelName = UILabel()
  var labelEmail = UILabel()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init() {
    super.init(style: .default, reuseIdentifier: "")
    setUpView()
  }
  
  /*
   Private setUpView() func.
   This functions add and sets all the elements of the cell.
   */
  
  private func setUpView() {
    self.contentView.addSubview(userPicture)
    userPicture.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(self.contentView)
      make.leading.equalTo(self.contentView).offset(15)
      make.size.equalTo(60)
    }
    userPicture.translatesAutoresizingMaskIntoConstraints = false
    userPicture.roundImage(withBorder: true, borderColor: .black, borderSize: 1.0)
    userPicture.image = R.image.logo()
    
    self.contentView.addSubview(labelName)
    labelName.snp.makeConstraints { (make) -> Void in
      make.leading.equalTo(userPicture.snp.trailing).offset(10)
      make.bottom.equalTo(self.contentView.snp.centerY).offset(-3)
      make.trailing.equalTo(self.contentView).offset(-15)
    }
    labelName.translatesAutoresizingMaskIntoConstraints = false
    
    self.contentView.addSubview(labelEmail)
    labelEmail.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.contentView.snp.centerY).offset(3)
      make.leading.equalTo(userPicture.snp.trailing).offset(10)
      make.trailing.equalTo(self.contentView).offset(-15)
    }
    labelEmail.translatesAutoresizingMaskIntoConstraints = false
    labelEmail.text = "test@test.com"
    labelEmail.textColor = UIColor.lightGray
  }
}
