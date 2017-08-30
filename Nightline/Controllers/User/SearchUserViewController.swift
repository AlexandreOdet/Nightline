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

    @IBAction func changeSearchCat(_ sender: Any) {
        self.tableView.reloadData()
    }


    let userInstance = RAUser()
    let estabInstance = RAEtablissement()
    var searchResult: SearchResult?
    var userArray: [UserPreview] = []
    var estabArray: [UserPreview] = []
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
                        if result.resultUser != nil {
                            self.userArray.append(contentsOf: result.resultUser)
                            for elem in self.userArray {
                                print(elem.name)
                            }
                            self.tableView.reloadData()
                        }
                    }.catch { error -> Void in
                        print("Error : \(error)")
                }
            case 1:
                firstly {
                    estabInstance.searchEstablishment(query: query)
                    }.then { result -> Void in
                        self.estabArray = []
                        if result.resultEstab != nil {
                            self.estabArray.append(contentsOf: result.resultEstab)
                            for elem in self.estabArray {
                                print(elem.name)
                            }
                            self.tableView.reloadData()
                        }
                    }.catch { error -> Void in
                        print("Error : \(error)")
                    }
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
        switch searchOption.selectedSegmentIndex {
        case 0:
            return userArray.count
        default:
            return estabArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel()
        cell.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        switch searchOption.selectedSegmentIndex {
        case 0:
            label.text = userArray[indexPath.row].name
        default:
            label.text = estabArray[indexPath.row].name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchOption.selectedSegmentIndex {
        case 0:
            firstly {
                userInstance.getUserInfos(id: String(userArray[indexPath.row].id))
                }.then { result -> Void in
                    DispatchQueue.main.async {
                        self.presentUserDetails(user: result.user)
                    }
                }.catch { error -> Void in
                    print(error)
                    self.user = nil
            }
        default:
            firstly {
                estabInstance.getEtablishmentProfile(idEtablishment: estabArray[indexPath.row].id)
                }.then { result -> Void in
                    DispatchQueue.main.async {
                        self.presentEstabDetails(estab: result.establishment)
                    }
                }.catch { error -> Void in
                    print(error)
                    self.user = nil
            }
        }
    }

    func presentUserDetails(user: User) {
        let nextVC = DetailUserViewController()
        nextVC.user = user
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func presentEstabDetails(estab: Etablissement) {
        let nextVC = EtablishmentViewController()
        nextVC.idBar = estab.id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
