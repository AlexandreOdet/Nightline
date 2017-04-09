//
//  ProfilePictCell.swift
//  Nightline
//
//  Created by cedric moreaux on 09/04/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class ProfilePictCell: UITableViewCell {
  
  var userPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
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
    
  }
  
}
