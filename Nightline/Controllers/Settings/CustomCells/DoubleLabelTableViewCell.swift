//
//  DoubleLabelTableViewCell.swift
//  Nightline
//
//  Created by cedric moreaux on 13/04/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class DoubleLabelTableViewCell: UITableViewCell {
  
    let labelRight = UILabel()
    let labelLeft = UILabel()
  
    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    init() {
      super.init(style: .default, reuseIdentifier: "")
      setUpView()
    }
    
    /*
     Private setUpView() func.
     This functions add and sets all the elements of the cell.
     */
    
    private func setUpView() {

      self.contentView.addSubview(labelRight)
      labelRight.snp.makeConstraints { (make) -> Void in
        make.centerY.equalTo(self.contentView)
        make.leading.equalTo(contentView).offset(15)
      }
      labelRight.text = "Profil picture"
      
      self.contentView.addSubview(labelLeft)
      labelLeft.snp.makeConstraints { (make) -> Void in
        make.centerY.equalTo(self.contentView)
        make.trailing.equalTo(contentView).offset(-15)
      }
    }
    
}

