//
//  EditPictureViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 14/04/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class EditPictureViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  let contentView = UIView()
  let picture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
  let imagePicker = UIImagePickerController()
  var imageData : NSData? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = self.backgroundColor()
    self.view.addSubview(contentView)
    contentView.snp.makeConstraints { make in
      make.edges.equalTo(self.view)
    }
    contentView.translatesAutoresizingMaskIntoConstraints = false
    self.contentView.addSubview(picture)
    self.picture.snp.makeConstraints { make in
      make.width.height.lessThanOrEqualTo(self.contentView.snp.width)
      make.center.equalTo(self.contentView)
    }
    picture.translatesAutoresizingMaskIntoConstraints = false
//    picture.roundImage()
    if let data = UserManager.instance.getUserPicture(), let img = UIImage(data: data as Data) {
        picture.image = img
    }
    picture.isUserInteractionEnabled = true
    imagePicker.delegate = self
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    picture.addGestureRecognizer(tapGestureRecognizer)
}
  
  @objc func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      picture.image = selectedImage
      picture.contentMode = .scaleAspectFill
      picture.clipsToBounds = true
      imageData = UIImageJPEGRepresentation(selectedImage, 0.1)! as NSData
      UserManager.instance.updateUserPicture(newValue: imageData!)
    }
    dismiss(animated: true, completion: nil)
  }
}
