//
//  UserFriendsListTableViewCell.swift
//  Nightline
//
//  Created by Odet Alexandre on 25/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class UserFriendsListTableViewCell: UITableViewCell {
    let profileImage = UIImageView(frame: CGRect(x: 0, y: 0,
                                                 width: 50,
                                                 height: 50))
    let nameLabel = UILabel()

    init(reuseIdentifier: String, user: User?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpView()
        profileImage.roundImage(withBorder: true, borderColor: .black, borderSize: 1.0)
        if let user = user {
            CloudinaryManager.shared.downloadProfilePicture(withUserId: String(user.id)) { (img) in
                DispatchQueue.main.async {
                    self.profileImage.image = img
                }
            }
            nameLabel.text = user.nickname
        } else {
            nameLabel.text = "Aucun ami"
        }
    }

    init(reuseIdentifier: String, InvitUser: InvitationInformationSenderReceiver?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpView()
        profileImage.roundImage(withBorder: true, borderColor: .black, borderSize: 1.0)
        if let user = InvitUser {
            CloudinaryManager.shared.downloadProfilePicture(withUserId: String(user.id)) { (img) in
                DispatchQueue.main.async {
                    self.profileImage.image = img
                }
            }
            nameLabel.text = user.pseudo
        } else {
            nameLabel.text = "Aucun ami"
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        contentView.addSubview(profileImage)
        profileImage.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(50)
            make.centerY.equalToSuperview()
        }
        profileImage.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(5)
        }
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }

}
