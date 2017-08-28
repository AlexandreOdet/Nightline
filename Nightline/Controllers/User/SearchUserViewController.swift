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
    var user: User? = nil

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        if let query = searchField.text {
            switch searchOption.selectedSegmentIndex {
            case 0:
                firstly {
                    userInstance.searchUser(query: query)
                    }.then { result -> Void in
                        self.userArray = []
                        if result.result != nil {
                            self.userArray.append(contentsOf: result.result)
                            self.tableView.reloadData()
                            for elem in self.userArray {
                                print(elem.name)
                            }
                            self.tableView.reloadData()
                        }
                    }.catch { error -> Void in
                        print("Error : \(error)")
                }
            case 1:
                break
            // TODO search event query
            default:
                break
            }
        }
        self.tableView.reloadData()
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
        let label = UILabel()
        cell.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.text = userArray[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstly {
            userInstance.getUserInfos(id: String(userArray[indexPath.row].id))
            }.then { result -> Void in
//                self.user = result

                DispatchQueue.main.async {
                    self.presentUserDetails(user: result)
                }
            }.catch { error -> Void in
                print(error)
                self.user = nil
        }

    }

    func presentUserDetails(user: User) {
        let nextVC = DetailUserViewController()
        nextVC.user = user
//        present(nextVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }


}
