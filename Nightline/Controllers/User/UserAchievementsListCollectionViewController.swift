//
//  UserAchievementsListTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 25/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class UserAchievementsListCollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var collectionView: UICollectionView!
  private let reuseIdentifier = "AchievementItemIdentifier"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCollectionView()
    self.view.backgroundColor = UIColor.white
  }
  
  private func setUpCollectionView() {
    let collectionViewLayout = UICollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .horizontal
    collectionViewLayout.itemSize = CGSize(width: self.width * 19/20, height: self.height / 4)
    collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: -10)

    self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
    self.collectionView?.register(AchievementCollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
    
    self.view.addSubview(self.collectionView)
    self.collectionView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset(60)
      make.trailing.equalTo(self.view)
      make.leading.equalTo(self.view)
      make.bottom.equalTo(self.view)
    }
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionView.reloadData()
    collectionView.backgroundColor = UIColor.init(hex: 0x331D0B)
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return AchievementManager.instance.achievementArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    log.debug("Item Clicked")
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? AchievementCollectionViewCell
    cell!.contentView.backgroundColor = .black
    cell!.titleLabel.text = AchievementManager.instance.achievementArray[indexPath.row].description
    if UserManager.instance.getAchievementStatus(AchievementManager.instance.achievementArray[indexPath.row].name) == true {
      cell!.titleLabel.textColor = UIColor.green
    }
    cell!.img.image = AchievementManager.instance.achievementArray[indexPath.row].img.image
    cell!.labelPoints.text = AchievementManager.instance.achievementArray[indexPath.row].points.toString() + " pts"
    return cell!
  }
  
}
