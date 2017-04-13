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
    picture.image = UIImage(data: UserManager.instance.getUserPicture()! as Data)
    picture.isUserInteractionEnabled = true
    imagePicker.delegate = self
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    picture.addGestureRecognizer(tapGestureRecognizer)
  }
  
  func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      imagePicker.allowsEditing = false
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      present(imagePicker, animated: true, completion: nil)
    }
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
