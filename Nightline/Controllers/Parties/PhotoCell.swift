//
//  PhotoCell.swift
//  Nightline
//
//  Created by cedric moreaux on 23/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCell: UICollectionViewCell {
  let imageView = UIImageView()
  
//  init(reuseIdentifier: String ,image: UIImage, frame: CGRect) {
//    super.init(frame: frame)
//    imageView.image = image
//    self.contentView.addSubview(imageView)
//    imageView.snp.makeConstraints { (make) in
//      make.edges.equalToSuperview()
//    }
//  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
