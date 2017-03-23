//
//  EtablishementViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class EtablishmentViewController: BaseViewController {
  
  var nameLabel = UILabel()
  var descriptionLabel = UILabel()
  var typeEtablishementLabel = UILabel()
  var likeImage = UIImageView()
  var isLiked = false
  var accessMenuButton = UIButton()
  var imageEtablishment = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    setUpView()
  }
  
  private func setUpView() {
    self.view.addSubview(imageEtablishment)
    imageEtablishment.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view)
      make.width.equalTo(self.view)
      make.height.equalTo(300)
    }
    imageEtablishment.translatesAutoresizingMaskIntoConstraints = false
    imageEtablishment.image = R.image.bar()
    
    self.view.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(imageEtablishment.snp.bottom).offset(5)
      make.leading.equalTo(self.view).offset(5)
      make.trailing.equalTo(self.view.snp.centerX).offset(-5)
    }
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.text = "Super bar du 34".uppercased()
    nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
    nameLabel.textColor = UIColor.darkGray
    
    self.view.addSubview(likeImage)
    likeImage.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(nameLabel)
      make.trailing.equalTo(self.view).offset(-5)
      make.size.equalTo(30)
      make.bottom.equalTo(nameLabel)
    }
    likeImage.translatesAutoresizingMaskIntoConstraints = false
    likeImage.image = (isLiked == true) ? R.image.like() : R.image.like_empty()
    
    let likeImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeImageOnClickTarget))
    likeImageGestureRecognizer.numberOfTapsRequired = 1
    likeImage.isUserInteractionEnabled = true
    likeImage.addGestureRecognizer(likeImageGestureRecognizer)
    
    self.view.addSubview(typeEtablishementLabel)
    typeEtablishementLabel.snp.makeConstraints { (make) -> Void in
      make.leading.equalTo(self.view.snp.centerX).offset(5)
      make.trailing.equalTo(likeImage.snp.leading).offset(-3)
      make.top.equalTo(nameLabel)
      make.bottom.equalTo(nameLabel)
    }
    typeEtablishementLabel.translatesAutoresizingMaskIntoConstraints = false
    typeEtablishementLabel.text = Etablishment.pub.toString()
    typeEtablishementLabel.textColor = .lightGray
  }
  
  func likeImageOnClickTarget() {
    (isLiked == true) ? unlikeEtablishment() : likeEtablishment()
  }
  
  func likeEtablishment() {
    likeImage.image = R.image.like()
    Animation().bounceEffect(sender: likeImage)
    self.isLiked = true
  }
  
  func unlikeEtablishment() {
    likeImage.image = R.image.like_empty()
    Animation().bounceEffect(sender: likeImage)
    self.isLiked = false
  }
  
}
