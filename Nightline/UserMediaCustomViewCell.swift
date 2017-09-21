//
//  UserFriendsListTableViewCell.swift
//  Nightline
//
//  Created by Odet Alexandre on 25/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class UserMediaCustomViewCell: UITableViewCell {
  var profileImage = UIImageView(frame: CGRect(x: 0, y: 0,
                                               width: 50,
                                               height: 50))
  
  init(reuseIdentifier: String) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    setUpView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpView() {
    contentView.addSubview(profileImage)
    profileImage.snp.makeConstraints { (make) -> Void in
      make.leading.equalToSuperview().offset(10)
      make.size.equalTo(50)
      make.centerY.equalToSuperview()
    }
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
}

