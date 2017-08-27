//
//  SearchUserViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 22/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class SearchUserViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchOption: UISegmentedControl!

    let userInstance = RAUser()
    var searchResult: SearchResult?
    var userArray: [UserPreview] = []
    let user = RAUser()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchFriendAction(_ sender: Any) {
        let query = searchField.text
        switch searchOption.selectedSegmentIndex {
        case 0:
            firstly {
                user.searchUser(query: query!)
                }.then { result -> Void in
                    self.userArray.append(contentsOf: result.result)
                    self.tableView.reloadData()
                }.catch { error -> Void in
                    let alert = UIAlertController(title: "MonTitre", message: "Mon message", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        case 1:
            break
            // TODO search event query
        default:
            break
        }
    }
}

extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }


}
