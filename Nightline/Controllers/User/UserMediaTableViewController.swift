//
//  UserMediaTableViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class UserMediaTableViewController: UITableViewController {
  
  var images : [UIImage] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    images = MediaManager.instance.getAllImages()
  }
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    print()
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
//    return images.count
    print(images.count)
    return images.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UserMediaCustomViewCell(reuseIdentifier: "UserMediaCustomViewCell")
    cell.profileImage.image = images[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
}
