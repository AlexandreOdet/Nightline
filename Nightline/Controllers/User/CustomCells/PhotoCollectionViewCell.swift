//
//  PhotoCollectionViewCell.swift
//  Nightline
//
//  Created by cedric moreaux on 03/12/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    let deepBlue = UIColor(hex: 0x0e1728)

    func setImg(img: UIImage) {
        self.imageView.image = img
    }

    func setImg(withUrl url: String) {
        let url = URL(string: url)
        self.imageView.kf.setImage(with: url)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = deepBlue.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        // Initialization code
    }

}
