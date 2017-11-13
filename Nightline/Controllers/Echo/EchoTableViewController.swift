//
//  EchoTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 13/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Starscream

class EchoTableViewController: BaseViewController {
  var messages = [String]()
  
  var tableView: UITableView!
  var textfield = UITextField()
  
  let reuseIdentifier = "echoTableViewCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  
  func setUpView() {
    view.addSubview(textfield)
    textfield.snp.makeConstraints { (make) -> Void in
      make.bottom.equalToSuperview().offset(-50)
      make.width.equalToSuperview()
      make.height.equalTo(30)
    }
    textfield.placeholder = "Ecrivez votre message ici"
    textfield.returnKeyType = .done
    textfield.delegate = self
    textfield.backgroundColor = .white
    
    tableView = UITableView(frame: view.frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.top.equalToSuperview()
      make.width.equalToSuperview()
      make.bottom.equalTo(textfield.snp.top)
    }
  }
  
  override func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    super.websocketDidReceiveMessage(socket: socket, text: text)
    messages.append(text)
    tableView.reloadData()
  }
}

extension EchoTableViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let text = textField.text {
      if !text.isEmpty {
        ws.write(string: text)
        textField.text = ""
      }
    }
    return true
  }
}

extension EchoTableViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    cell.textLabel?.text = messages[indexPath.row]
    return cell
  }
}
