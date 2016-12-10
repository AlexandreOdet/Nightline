
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
  
  var headerView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.backgroundColor = UIColor.white
      self.addComponentsToView()
    }
  }
  
  private func addComponentsToView() {
    self.view.addSubview(headerView)
    headerView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
      make.height.equalTo(UIScreen.main.bounds.width * (9/16))
      make.width.equalTo(UIScreen.main.bounds.width)
    }
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.backgroundColor = UIColor.black
    self.headerView.addSubview(userProfilePicture)
    userProfilePicture.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(self.headerView)
      make.leading.equalTo(self.headerView).offset(15)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
    userProfilePicture.roundImage()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

}
