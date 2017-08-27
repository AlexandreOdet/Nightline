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
import Lightbox

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
    cv.showsHorizontalScrollIndicator = false
    return cv
  }()
    let imagePicker = UIImagePickerController()

  
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
//      make.bottom.equalTo(self.camButton.snp.top).offset(-30)
      make.top.equalTo(self.separatorView).offset(20)
      make.left.right.equalToSuperview()
      make.height.equalTo(150)
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
    switch indexPath.section {
    case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        let img = UIImageView()
        img.image = UIImage(named: "newPhotoIconWp")
        cell.addSubview(img)
        img.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return cell
    default:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        let img = UIImageView()
        img.image = images[indexPath.row]
        img.contentMode = .scaleAspectFill
        cell.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return cell
    }

  }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            takePicture()
        default:
            let diapo = images.map {LightboxImage(image: $0)}
            let diapoController = LightboxController(images: diapo, startIndex: indexPath.row)
            diapoController.dynamicBackground = true
            present(diapoController, animated: true, completion: nil)
        }
    }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
        return 1
    default:
        return images.count
    }
  }
}

extension EtablishmentViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.mediaBook.frame.height, height: self.mediaBook.frame.height)
  }
}

extension EtablishmentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func photoFromLibrairy() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            let needAuthorization = UIAlertController(title: "Impossible", message: "Veuillez autoriser l'application a acceder a votre bibliotheque photo dans les reglages de l'appareil", preferredStyle: .alert)
            present(needAuthorization, animated: true, completion: nil)
        }
    }

    func photoFromCamera() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker,animated: true,completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            MediaManager.instance.saveImage(bar_id: String(idBar), image: selectedImage)
            mediaBook.reloadData()
        }
        self.mediaBook.reloadData()
        dismiss(animated: true, completion: nil)
    }

    func takePicture() {
        let chooseSource = UIAlertController(title: "Choix de la source", message: "?", preferredStyle: .actionSheet)
        let roll = UIAlertAction(title: "Bibliothèque", style: .default, handler: {
            action in
            self.photoFromLibrairy()
        })
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.photoFromCamera()
        })
        chooseSource.addAction(roll)
        chooseSource.addAction(camera)
        present(chooseSource, animated: true, completion: nil)
    }
}









