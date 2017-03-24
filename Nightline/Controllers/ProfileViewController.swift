//
//  ProfileViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 24/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: BaseViewController {
  
  var isUser = false
  var imgHeader = UIImageView()
  var imgProfile = UIImageView(frame: CGRect(x: 0, y: 0,
                                             width: AppConstant.UI.Dimensions.thumbnailPictureSize,
                                             height: AppConstant.UI.Dimensions.thumbnailPictureSize))
  
  private var separatorView = UIView()
  private var infoContainerView = UIView()
  var nameLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    self.addHeader()
    addProfilePicture()
  }
  
  private func addHeader() {
    if isUser {
      imgHeader.image = R.image.party()
    }
    self.view.addSubview(imgHeader)
    imgHeader.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view)
      make.width.equalTo(self.view)
      make.height.equalTo(250)
    }
    imgHeader.translatesAutoresizingMaskIntoConstraints = false
    imgHeader.isUserInteractionEnabled = false
  }
  
  private func addProfilePicture() {
    imgProfile.roundImage(withBorder: true, borderColor: UIColor.black, borderSize: 1.0)
    self.view.addSubview(imgProfile)
    imgProfile.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.view)
      make.centerY.equalTo(imgHeader.snp.bottom)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    imgProfile.translatesAutoresizingMaskIntoConstraints = false
  }
}
