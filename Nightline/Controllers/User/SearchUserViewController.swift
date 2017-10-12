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

    deinit {
        userInstance.cancelRequest()
        estabInstance.cancelRequest()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(hex: 0x0e1728)
        self.tableView.separatorColor = UIColor(hex: 0x0e1728)
        self.searchField.backgroundColor = UIColor(hex: 0x363D4C)
        self.searchField.layer.cornerRadius = self.searchField.frame.size.height / 2
        self.searchField.setLeftPaddingPoints(15)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchFriendAction(_ sender: Any) {
        self.searchField.resignFirstResponder()
        if let query = searchField.text {
            switch searchOption.selectedSegmentIndex {
            case 0:
                firstly {
                    userInstance.searchUser(query: query)
                    }.then { [weak self] result -> Void in
                        guard let strongSelf = self else { return }
                        strongSelf.userArray = []
                        if result.resultUser != nil {
                            strongSelf.userArray.append(contentsOf: result.resultUser)
                            for elem in strongSelf.userArray {
                                print(elem.name)
                            }
                            strongSelf.tableView.reloadData()
                        }
                    }.catch { error -> Void in
                        print("Error : \(error)")
                }
            case 1:
                firstly {
                    estabInstance.searchEstablishment(query: query)
                    }.then { [weak self] result -> Void in
                        guard let strongSelf = self else { return }
                        strongSelf.estabArray = []
                        if result.resultEstab != nil {
                            strongSelf.estabArray.append(contentsOf: result.resultEstab)
                            for elem in strongSelf.estabArray {
                                print(elem.name)
                            }
                            strongSelf.tableView.reloadData()
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let bg = UIView()
        cell.addSubview(bg)
        bg.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        bg.clipsToBounds = true
        bg.layer.cornerRadius = (cell.frame.size.height - 5) / 2
        bg.backgroundColor = UIColor(hex : 0x363D4C)
        let label = UILabel()
        bg.addSubview(label)
        cell.backgroundColor = UIColor(hex: 0x0e1728)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.left.equalToSuperview().inset(15)
        }
        label.textColor = UIColor(hex: 0xE88B26)
        switch searchOption.selectedSegmentIndex {
        case 0:
            label.text = userArray[indexPath.row].name
        default:
            label.text = estabArray[indexPath.row].name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
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
