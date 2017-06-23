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
  let recImage = UIImage(named: "rec")
  let stopImage = UIImage(named: "stop")
  let returnImage = UIImage(named: "back_arrow")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cameraDelegate = self
    captureButton.delegate = self
    self.view.addSubview(captureButton)
    captureButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-20)
      make.size.equalTo(70)
    }
    captureButton.setImage(recImage, for: .normal)
    captureButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    
    self.view.addSubview(returnButton)
    returnButton.snp.makeConstraints { (make) in
      make.size.equalTo(70)
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview()
    }
    returnButton.setImage(returnImage, for: .normal)
    returnButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
  }
  
  func dismissView() {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
    print("Hey you took a photo!")
  }
  
}
