//
//  DetailMediaViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 23/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class DetailMediaViewController: UIViewController, UIViewControllerTransitioningDelegate {
  
  let imageView: UIImageView = UIImageView()
  let backButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    imageView.contentMode = .scaleAspectFill
    self.view.addSubview(backButton)
    backButton.snp.makeConstraints { (make) in
      make.bottom.left.equalToSuperview()
      make.size.equalTo(50)
    }
    backButton.setImage(UIImage(named: "back_arrow"), for: .normal)
    backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
  }

func dismissView() {
  self.dismiss(animated: true, completion: nil)
}

override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
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

extension DetailMediaViewController: ZoomingViewController {
  func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
    return imageView
  }
  
  func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
    return nil
  }
}
