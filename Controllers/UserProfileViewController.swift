
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
  var imageNightline = UIImageView()
  var nameApp = UILabel()
  var currentVersion = UILabel()
  
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
      make.centerX.equalTo(self.view)
      make.top.equalTo(self.view).offset(80)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
    userProfilePicture.roundImage()
    addCurrentVersion()
  }
  
  private func addCurrentVersion() {
    self.currentVersion.text = Utils.Files.getAppCurrentVersion()
    self.view.addSubview(currentVersion)
    currentVersion.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(userProfilePicture.snp.bottom).offset(15)
      make.centerX.equalTo(self.view)
    }
    currentVersion.translatesAutoresizingMaskIntoConstraints = false
    currentVersion.textColor = UIColor.white
    currentVersion.numberOfLines = 0
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func pullToRefreshTask() {
    print("UserProfileViewController pulls down to refresh")
  }
}
