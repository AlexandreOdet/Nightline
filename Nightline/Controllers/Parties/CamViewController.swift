//
//  CamController.swift
//  Nightline
//
//  Created by cedric moreaux on 19/06/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import SwiftyCam

class CamViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
  
  let captureButton = SwiftyCamButton()
  let returnButton = UIButton()
  var bar_id = "0"
  let recImage = UIImage(named: "rec")
  let stopImage = UIImage(named: "stop")
  let returnImage = UIImage(named: "back_arrow_down")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cameraDelegate = self
    captureButton.delegate = self
    view.addSubview(captureButton)
    captureButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-20)
      make.size.equalTo(70)
    }
    captureButton.setImage(recImage, for: .normal)
    captureButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    
    view.addSubview(returnButton)
    returnButton.snp.makeConstraints { (make) in
      make.size.equalTo(70)
      make.bottom.equalToSuperview().offset(-20)
      make.left.equalToSuperview().offset(20)
    }
    returnButton.setImage(returnImage, for: .normal)
    returnButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
  }
  
  @objc func dismissView() {
    dismiss(animated: true, completion: nil)
  }
  
//  func saveImageDocumentDirectory(image: UIImage, title: String){
//    let fileManager = FileManager.default
//    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("\(title).jpg")
//    print(paths)
//    let imageData = UIImageJPEGRepresentation(image, 0.5)
//    fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
//  }
  
  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
    MediaManager.instance.saveImage(bar_id: bar_id, image: photo)
  }
  
}


