//
//  CamController.swift
//  Nightline
//
//  Created by cedric moreaux on 19/06/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import SwiftyCam

class CamViewController: SwiftyCamViewController {
  
  let captureButton = SwiftyCamButton()
  let returnButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    captureButton.delegate = self
    self.view.addSubview(captureButton)
    captureButton.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview()
    }
    captureButton.backgroundColor = .red
    
    self.view.addSubview(returnButton)
    returnButton.snp.makeConstraints { (make) in
      make.size.equalTo(70)
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview()
    }
    let returnImage = UIImage(named: "back_arrow")
    returnButton.setImage(returnImage, for: .normal)
    returnButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
  }
  
  func dismissView() {
    self.dismiss(animated: true, completion: nil)
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
