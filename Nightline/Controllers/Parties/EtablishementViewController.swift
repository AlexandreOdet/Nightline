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

class EtablishmentViewController: ProfileViewController {
  var isLiked = false
  private let animation = Animation()
  
  override func viewDidLoad() {
    self.isUser = false
    super.viewDidLoad()
    setUpView()
  }
  
  private func setUpView() {
    self.imgHeader.image = R.image.bar()
    self.imgProfile.image = R.image.test_logo()
    self.nameLabel.text = "Big Mama".uppercased()
    self.likeButton.image = (!isLiked) ? R.image.heart() : R.image.heart_filled()
    self.likeButton.isUserInteractionEnabled = true
    
    let likeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonTarget))
    likeTapGestureRecognizer.numberOfTapsRequired = 1
    self.likeButton.addGestureRecognizer(likeTapGestureRecognizer)
    
    self.typeLabel.text = Etablishment.bar.toString()
    self.locationLabel.text = "Montpellier"
    self.descriptionLabel.text = "Des bonnes bières, des bons burgers, il ne manque que vous !"
    
    let imgMenu = R.image.menu()
    img.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(10)
    }
    let button1 = UIBarButtonItem(image: imgMenu, style: .plain, target: self,
                                  action: #selector(displayEtablishmentMenuViewController))
    self.navigationItem.rightBarButtonItem  = button1
  }
  
  func likeButtonTarget() {
    self.isLiked = !self.isLiked
    self.likeButton.image = (!isLiked) ? R.image.heart() : R.image.heart_filled()
    animation.bounceEffect(sender: self.likeButton)
  }
  
  func displayEtablishmentMenuViewController() {
    if let nav = self.navigationController {
      let nextViewController = EtablishmentMenuViewController()
      nav.pushViewController(nextViewController, animated: true)
    }
  }
}
