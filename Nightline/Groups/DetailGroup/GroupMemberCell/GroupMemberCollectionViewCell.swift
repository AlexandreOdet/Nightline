//
//  GroupMemberCollectionViewCell.swift
//  Nightline
//
//  Created by cedric moreaux on 09/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class GroupMemberCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var firstNameLabel:  UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var img: UIImageView!
    let deepBlue = UIColor(hex: 0x0e1728)
    let lightBlue = UIColor(hex : 0x363D4C)
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setView()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setView() {
        self.backgroundColor = deepBlue
        bg.backgroundColor = lightBlue
        bg.layer.cornerRadius = 10
        bg.clipsToBounds = true
        firstNameLabel.isUserInteractionEnabled = false
        lastNameLabel.isUserInteractionEnabled = false
    }
    
    func setData(usr: User) {
        print("firstname = \(usr.firstName)")
        firstNameLabel.text = usr.firstName
        lastNameLabel.text = usr.lastName
        img.roundImage(withBorder: true, borderColor: UIColor(hex: 0x0e1728), borderSize: 1.0)
        CloudinaryManager.shared.downloadProfilePicture(withUserId: String(usr.id)) { (img) in
            DispatchQueue.main.async {
                self.img.image = img
            }
        }
    }
}

