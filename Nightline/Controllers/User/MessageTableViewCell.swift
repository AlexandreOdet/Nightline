//
//  MessageTableViewCell.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bgView: UIView!

    func setCell(msg: String, sender: String) {
        self.messageLabel.text = msg
        self.senderNameLabel.text = sender + ":"
        self.bgView.layer.cornerRadius = 5
        self.backgroundColor = .clear
        if sender == "moi" {
            senderNameLabel.textColor = .black
        } else {
            senderNameLabel.textColor = .orange
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
