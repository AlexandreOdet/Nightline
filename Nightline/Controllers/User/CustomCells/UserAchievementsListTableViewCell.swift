//
//  UserAchievementsListTableViewCell.swift
//  Nightline
//
//  Created by Odet Alexandre on 25/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AchievementCollectionViewCell: UICollectionViewCell {
  var labelPoints = UILabel()
  var titleView = UIView()
  var titleLabel = UILabel()
  var img = UIImageView()
  
  init(title: String, points: Int, image: UIImageView) {
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.contentView.backgroundColor = .black
    setUpView()
  }
  
  private func setUpView() {
    self.contentView.addSubview(titleView)
    titleView.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.contentView)
      make.width.equalTo(self.contentView)
      make.height.equalTo(50)
    }
    titleView.backgroundColor = UIColor.white
    titleView.translatesAutoresizingMaskIntoConstraints = false
    
    titleView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(titleView)
      make.leading.equalTo(titleView).offset(15)
      make.trailing.equalTo(titleView).offset(-15)
    }
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    
    
    self.contentView.addSubview(img)
    img.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.contentView)
      make.centerY.equalTo(self.contentView).offset(-20)
      make.size.equalTo(60)
    }
    img.translatesAutoresizingMaskIntoConstraints = false
    
    self.contentView.addSubview(labelPoints)
    labelPoints.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.contentView)
      make.trailing.equalTo(self.contentView).offset(-5)
    }
    labelPoints.translatesAutoresizingMaskIntoConstraints = false
    labelPoints.textColor = .white
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
    titleLabel.text = ""
    labelPoints.text =  "120 pts"

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
