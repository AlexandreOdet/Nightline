//
//  UserMediaTableViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class UserMediaTableViewController: UITableViewController {
  
  var mediaNames : [String] = []
  override func viewDidLoad() {
        super.viewDidLoad()
      mediaNames = listMedia()
      
      
    }

  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mediaNames.count
    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UserMediaCustomViewCell(reuseIdentifier: "UserMediaCustomViewCell")
    cell.profileImage.image = getImage(title: mediaNames[indexPath.row] + "jpg")
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  
  func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
  
  func getImage(title: String) -> UIImage{
    let fileManager = FileManager.default
    let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("\(title).jpg")
    if fileManager.fileExists(atPath: imagePAth){
      print("OK")
      return UIImage(contentsOfFile: imagePAth)!
    }else{
      print("No Image")
    }
    return UIImage(named: "AppIcon")!
  }
  
  func listMedia() -> [String]{
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    do {
      // Get the directory contents urls (including subfolders urls)
      let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
      print(directoryContents)
      
      // if you want to filter the directory contents you can do like this:
      let mp3Files = directoryContents.filter{ $0.pathExtension == "jpg" }
      print("jpg urls:",mp3Files)
      let mediaNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
      print("mp3 list:", mediaNames)
      return mediaNames
    } catch let error as NSError {
      print(error.localizedDescription)
    }
    return []
  }
}
