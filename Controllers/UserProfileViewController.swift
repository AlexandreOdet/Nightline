
//
//  UserProfileViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class UserProfileViewController: BaseViewController {
  
  var userProfilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.backgroundColor = UIColor.black
      self.addComponentsToView()
    }
  }
  
  private func addComponentsToView() {
    self.view.addSubview(userProfilePicture)
    userProfilePicture.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
    userProfilePicture.roundImage()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func pullToRefreshTask() {
    print("UserProfileViewController pulls down to refresh")
  }
}
