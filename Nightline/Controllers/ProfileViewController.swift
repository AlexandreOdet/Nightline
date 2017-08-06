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
  
  var separatorView = UIView()
  var infoContainerView = UIView()
  var nameLabel = UILabel()
  var typeLabel = UILabel()
  var nicknameLabel = UILabel()
  var birthdayLabel = UILabel()
  var likeButton = UIImageView()
  var locationLabel = UILabel()
  var descriptionLabel = UILabel()
  
  let friendsView = UIView()
  let pictureView = UIView()
  let trophyView = UIView()
  
  let friendsLabel = UILabel()
  let pictureLabel = UILabel()
  let trophyLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    addHeader()
    addProfilePicture()
    addInfoContainerView()
    fillInfoContainerView()
    if isUser {
      addUserNumbers()
    } else {
      addEtablishmentMedia()
    }
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
    imgProfile.backgroundColor = .white
  }
  
  private func addInfoContainerView() {
    self.view.addSubview(infoContainerView)
    infoContainerView.backgroundColor = UIColor.clear
    infoContainerView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(imgHeader.snp.bottom)
      make.width.equalTo(self.view)
      make.height.equalTo(150)
    }
    infoContainerView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(separatorView)
    separatorView.backgroundColor = UIColor.lightGray
    separatorView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(infoContainerView.snp.bottom)
      make.height.equalTo(1)
      make.width.equalTo(self.view)
    }
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.isUserInteractionEnabled = false
  }
  
  private func fillInfoContainerView() {
    self.view.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(infoContainerView).offset(30)
      make.leading.equalTo(infoContainerView).offset(10)
      make.trailing.equalTo(infoContainerView.snp.centerX).offset(-3)
    }
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
    nameLabel.textColor = .darkGray
    
    if isUser {
      let birthdayImage = UIImageView()
      self.view.addSubview(nicknameLabel)
      nicknameLabel.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(nameLabel)
        make.trailing.equalTo(infoContainerView).offset(-10)
      }
      nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
      
      self.view.addSubview(birthdayImage)
      birthdayImage.image = R.image.birthday()
      birthdayImage.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(nameLabel.snp.bottom).offset(20)
        make.leading.equalTo(nameLabel)
        make.size.equalTo(20)
      }
      birthdayImage.isUserInteractionEnabled = false
      birthdayImage.translatesAutoresizingMaskIntoConstraints = false
      
      self.view.addSubview(birthdayLabel)
      birthdayLabel.snp.makeConstraints { (make) -> Void in
        make.bottom.equalTo(birthdayImage)
        make.leading.equalTo(birthdayImage.snp.trailing).offset(2)
      }
      birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
    } else {
      self.view.addSubview(likeButton)
      likeButton.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(nameLabel)
        make.trailing.equalTo(infoContainerView).offset(-10)
        make.size.equalTo(25)
      }
      likeButton.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(typeLabel)
      typeLabel.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(nameLabel.snp.bottom).offset(20)
        make.leading.equalTo(nameLabel)
        make.trailing.equalTo(nameLabel)
      }
      typeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    addLocation()
    addDescription()
  }
  
  private func addLocation() {
    let locationImage = UIImageView()
    self.view.addSubview(locationLabel)
    if isUser {
      locationLabel.snp.makeConstraints { (make) -> Void in
        make.trailing.equalTo(nicknameLabel)
        make.centerY.equalTo(birthdayLabel)
      }
      locationLabel.translatesAutoresizingMaskIntoConstraints = false
    } else {
      locationLabel.snp.makeConstraints { (make) -> Void in
        make.trailing.equalTo(likeButton)
        make.centerY.equalTo(typeLabel)
      }
      locationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    self.view.addSubview(locationImage)
    locationImage.image = R.image.location()
    locationImage.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(locationLabel)
      make.size.equalTo(20)
      make.trailing.equalTo(locationLabel.snp.leading).offset(-3)
    }
    locationImage.translatesAutoresizingMaskIntoConstraints = false
    locationImage.isUserInteractionEnabled = false
  }
  
  private func addDescription() {
    self.view.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(infoContainerView).offset(-3)
      make.leading.equalTo(nameLabel)
      make.trailing.equalTo(locationLabel)
    }
    descriptionLabel.numberOfLines = 2
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.textAlignment = .center
    descriptionLabel.font = descriptionLabel.font.withSize(descriptionLabel.font.pointSize - 2)
  }
  
  private func addUserNumbers() {
    var sepators = [UIView]()
    sepators.append(UIView())
    sepators.append(UIView())
    sepators.append(UIView())
    
    initSeparators(array: sepators)
    
    let numberStackView = UIStackView()
    numberStackView.axis = .horizontal
    numberStackView.distribution = .equalCentering
    numberStackView.spacing = 1
    
    self.view.addSubview(numberStackView)
    numberStackView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(separatorView.snp.bottom)
      make.leading.equalTo(self.view).offset(15)
      make.trailing.equalTo(self.view).offset(-15)
      make.height.equalTo(50)
    }
    numberStackView.translatesAutoresizingMaskIntoConstraints = false
    
    let friendsImage = UIImageView()
    let pictureImage = UIImageView()
    let trophyImage = UIImageView()
    
    friendsImage.image = R.image.friends()
    pictureImage.image = R.image.picture()
    trophyImage.image = R.image.trophy()
    
    setImageSize(img: friendsImage)
    setImageSize(img: pictureImage)
    setImageSize(img: trophyImage)
    
    numberStackView.addArrangedSubview(friendsView)
    numberStackView.addArrangedSubview(sepators[0])
    numberStackView.addArrangedSubview(pictureView)
    numberStackView.addArrangedSubview(sepators[1])
    numberStackView.addArrangedSubview(trophyView)

    setUpContainerView(container: friendsView, img: friendsImage, label: friendsLabel)
    setUpContainerView(container: pictureView, img: pictureImage, label: pictureLabel)
    setUpContainerView(container: trophyView, img: trophyImage, label: trophyLabel)
    self.view.addSubview(sepators[2])
    sepators[2].snp.makeConstraints { (make) -> Void in
      make.top.equalTo(numberStackView.snp.bottom)
      make.width.equalTo(self.view)
      make.height.equalTo(1)
    }
    sepators[2].translatesAutoresizingMaskIntoConstraints = false
    sepators[2].backgroundColor = .lightGray
  }
  
  private func setImageSize(img: UIImageView) {
    img.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(20)
    }
  }
  
  private func setUpContainerView(container: UIView, img: UIImageView, label: UILabel) {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 3
    stackView.alignment = .center
    stackView.distribution = .equalCentering
    
    container.addSubview(stackView)
    stackView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(container)
      make.center.equalTo(container)
    }
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(img)
    stackView.addArrangedSubview(label)
  }
  
  private func initSeparators(array: [UIView]) {
    for view in array {
      if view != array.last!{
        view.snp.makeConstraints { (make) -> Void in
          make.width.equalTo(1)
          make.height.equalTo(50)
        }
      }
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .lightGray
    }
  }
  
  func addEtablishmentMedia() {
    
  }
  
}
