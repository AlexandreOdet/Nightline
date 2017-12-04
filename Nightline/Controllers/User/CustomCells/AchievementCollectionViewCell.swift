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

    var unlocked: Bool {
        print("Check status for achievement: name = \(achievementName) title = \(title)")
        print("status = \(UserManager.instance.getAchievementStatus(achievementName) ? "unlocked" : "locked")")
        return UserManager.instance.getAchievementStatus(achievementName)
    }

    func setCell(_ hf: Achievement) {
        self.achievementName = hf.name
        self.title = hf.title
        self.image = hf.img.image
        bgView.layer.cornerRadius = 5
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = deepBlue
        // Initialization code
    }
}
