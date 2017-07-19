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
import PromiseKit

class EtablishmentViewController: ProfileViewController {
  var isLiked = false
  private let animation = Animation()
  let camButton = UIButton()
  var idBar: Int!
  var restApiEtablissements = RAEtablissement()
  var images: [UIImage] = []
  let mediaBook : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  
  let cellId = "ImageCell"
  
  deinit {
    restApiEtablissements.cancelRequest()
  }
  
  override func viewDidLoad() {
    self.isUser = false
    super.viewDidLoad()
    setUpView()
    fetchData()
    images = MediaManager.instance.getImagesOfBar(bar_id: String(idBar))
    setupMediaBook()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    images = MediaManager.instance.getImagesOfBar(bar_id: String(idBar))
    self.mediaBook.reloadData()
  }
  
  func pushCamViewController() {
    let nextViewController = CamViewController()
    nextViewController.bar_id = String(idBar)
    self.navigationController?.present(nextViewController, animated: true, completion: nil)
  }
  
  func setupMediaBook() {
    mediaBook.backgroundColor = .white
    self.view.addSubview(mediaBook)
    mediaBook.snp.makeConstraints { (make) in
      make.bottom.equalTo(self.camButton.snp.top).offset(-30)
      make.left.right.equalToSuperview()
      make.height.equalTo(200)
    }
    mediaBook.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    mediaBook.dataSource = self
    mediaBook.delegate = self
    // LoadListOfImages()
  }
  
  // CollectionView functions:
  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return self.images.count
//  }
  
  // End collectionview functions
  
  private func setUpView() {
    self.imgHeader.image = R.image.bar()
    self.imgProfile.image = R.image.test_logo()
    self.likeButton.image = (!isLiked) ? R.image.heart() : R.image.heart_filled()
    self.likeButton.isUserInteractionEnabled = true
    
    let likeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonTarget))
    likeTapGestureRecognizer.numberOfTapsRequired = 1
    self.likeButton.addGestureRecognizer(likeTapGestureRecognizer)
    
    self.typeLabel.text = Etablishment.bar.toString()
    self.locationLabel.text = "Paris"
    self.descriptionLabel.text = ""
    
    let imgMenu = R.image.menu()
    img.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(10)
    }
    let button1 = UIBarButtonItem(image: imgMenu, style: .plain, target: self,
                                  action: #selector(displayEtablishmentMenuViewController))
    self.navigationItem.rightBarButtonItem  = button1
    
    self.view.addSubview(camButton)
    camButton.snp.makeConstraints { (make) -> Void in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
      make.size.equalTo(70)
    }
    let buttonImage = UIImage(named: "cameraButton")
    camButton.setImage(buttonImage, for: .normal)
    camButton.addTarget(self, action: #selector(pushCamViewController), for: .touchUpInside)
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
  
  func fetchData() {
    firstly {
      restApiEtablissements.getEtablishmentProfile(idEtablishment: self.idBar)
      }.then { etabl -> Void in
        self.nameLabel.text = etabl.name.uppercased()
      }.catch { _ in
        AlertUtils.networkErrorAlert(fromController: self)
    }
  }
}

extension EtablishmentViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .white
    let test = UIImageView()
    test.image = images[indexPath.row]
    cell.addSubview(test)
    test.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
}

extension EtablishmentViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.mediaBook.frame.height, height: self.mediaBook.frame.height)
  }
}
