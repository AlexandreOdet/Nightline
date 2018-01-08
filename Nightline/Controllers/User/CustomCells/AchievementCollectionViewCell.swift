//
//  AchievementCollectionViewCell.swift
//  Nightline
//
//  Created by cedric moreaux on 04/12/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class AchievementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let deepBlue = UIColor(hex: 0x0e1728)
    var achievementName = ""
    var title = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    var image: UIImage? {
        didSet {
            if let img = self.image {
                if unlocked {
                    imgView.image = img
                    bgView.backgroundColor = bgView.backgroundColor?.alpha(0.4)
                } else {
                    imgView.image = img.withRenderingMode(.alwaysTemplate)
                    imgView.tintColor = deepBlue
                    bgView.backgroundColor = bgView.backgroundColor?.alpha(0.2)
                }
            }
        }
    }
    var unlocked = true

    func setCell(withSuccess success: Success) {
        self.title = success.name
        self.unlocked = success.isUnlocked
        self.image = UIImage(named: "trophy")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = deepBlue
        bgView.layer.cornerRadius = 5
    }
}
