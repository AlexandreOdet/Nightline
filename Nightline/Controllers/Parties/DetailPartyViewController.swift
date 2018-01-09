//
//  DetailPartyViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit
import TTGSnackbar

enum WhichDate {
  case to, from
}

struct LightDate {
  var date: String!
  var clock: String!
  
  init() {
    self.date = ""
    self.clock = ""
  }
  
  init(date: String, clock:String) {
    self.date = date
    self.clock = clock
  }
}

class DetailPartyViewController: BaseViewController {
  var bar_id = ""
  let estabInstance = RAEtablissement()
  let raPartyInstance = RAParty()
  var party: Party?
  var menu: Menu?
  let reuseIdentifer = "ConsommableCell"
  var hasJoin: Bool = false
  
  @IBOutlet weak var partyView: UIView!
  @IBOutlet weak var noParty: UIView!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var dateFrom: UILabel!
  @IBOutlet weak var clockFrom: UILabel!
  @IBOutlet weak var dateTo: UILabel!
  @IBOutlet weak var clockTo: UILabel!
  @IBOutlet weak var menuName: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  var basketDetailButton = UIButton()
  
  deinit {
    estabInstance.cancelRequest()
    raPartyInstance.cancelRequest()
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(basketEmptinessHasChanged),
                                           name: Notification.Name(rawValue: "BasketHasChanged"), object: nil)
    getPartyInfos()
    tableView.delegate = self
    tableView.dataSource = self
    self.tableView.backgroundColor = UIColor(hex: 0x0e1728)
    self.tableView.separatorColor = UIColor(hex: 0x0e1728)
    
    if navigationController != nil {
      log.verbose("Create rightBarButtonItem")
      let rightBarButtonItem = UIBarButtonItem(title: "Rejoindre cette soirée", style: .plain,
                                               target: self, action: #selector(rightBarButtonItemTarget))
      navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    view.addSubview(basketDetailButton)
    basketDetailButton.snp.makeConstraints { (make) -> Void in
      make.bottom.equalToSuperview()
      make.height.equalTo(40)
      make.width.equalToSuperview()
    }
    basketDetailButton.addTarget(self, action: #selector(goToBasketDetail), for: .touchUpInside)
    basketDetailButton.backgroundColor = .blue
    basketDetailButton.setTitle("Voir mon panier", for: .normal)
    basketDetailButton.setTitleColor(.white, for: .normal)
    basketDetailButton.isHidden = true
    // Do any additional setup after loading the view.
  }
  
  func setView() {
    if party != nil {
      noParty.isHidden = true
      partyView.isHidden = false
      descLabel.text = party?.description
      displayDate(whichDate: .from, date: (party?.begin ?? ""))
      displayDate(whichDate: .to, date: (party?.end ?? ""))
      menu = party?.menu
      menuName.text = menu?.description
    } else {
      noParty.isHidden = false
      partyView.isHidden = true
    }
  }
  
  func getPartyInfos() {
    firstly {
      estabInstance.getEstablishmentParties(idEstablishment: bar_id)
      }.then { [weak self] result -> Void in
        guard let strongSelf = self else { return }
        strongSelf.party = result.party
        firstly {
          strongSelf.raPartyInstance.getPartyMenu(idSoiree: result.party.id!)
          }.then { response -> Void in
            print(response.toJSON())
            if let party = strongSelf.party {
              party.menu = response.menu
              party.menu.conso = response.menu.conso
            }
            DispatchQueue.main.async {
              strongSelf.setView()
              strongSelf.tableView.reloadData()
            }
          }.catch { error -> Void in
            log.error("Error while fetching menu: \(error)")
        }
      }.catch { error -> Void in
        log.error(error)
    }
  }
  
  func displayDate(whichDate: WhichDate, date: String) {
    let lightDate = cutDate(str: date)
    switch whichDate {
    case .to:
      dateTo.text = lightDate.date
      clockTo.text = lightDate.clock
    case .from:
      dateFrom.text = lightDate.date
      clockFrom.text = lightDate.clock
    }
  }
  
  func cutDate(str: String) -> LightDate {
    var dateSplited = str.split(separator: ",")
    let date = dateSplited[0]
    var clock = dateSplited[1]
    clock.removeLast(6)
    clock.removeFirst(9)
    return LightDate(date: String(date), clock: String(clock))
  }
  
  @objc func rightBarButtonItemTarget() {
    if !hasJoin {
      if let party = self.party {
        firstly {
          raPartyInstance.joinParty(idSoiree: "\(party.id!)", idUser: "\(UserManager.instance.retrieveUserId())")
          }.then {
            [weak self] response -> Void in
            print(response.toJSON())
            guard let `self` = self else { return }
            //self.party = response
            self.hasJoin = true
            self.navigationItem.rightBarButtonItem?.title = "Quitter la soirée"
            Basket.manager.addUserToOrder(userID: UserManager.instance.retrieveUserId())
          }.catch { error in
            log.error("Error while joining party")
        }
      }
    } else {
      if let party = self.party {
        raPartyInstance.leaveParty(idSoiree: "\(party.id)", idUser: "\(UserManager.instance.retrieveUserId())", callbackError: {
          [weak self] error in
          log.error("\(error)")
          guard let `self` = self else { return }
          self.hasJoin = true
          self.navigationItem.rightBarButtonItem?.title = "Quitter la soirée"
        })
        hasJoin = false
        self.navigationItem.rightBarButtonItem?.title = "Rejoindre la soirée"
        Basket.manager.clearOrder()
      }
    }
  }
  
  @objc func basketEmptinessHasChanged() {
    basketDetailButton.isHidden = Basket.manager.isBasketEmpty
  }
  
  @objc func goToBasketDetail() {
    if let consos = party?.menu.conso {
      let nextViewController = CurrentBasketFromPartyTableViewController(with: consos)
      navigationController?.pushViewController(nextViewController, animated: true)
    }
  }
}

extension DetailPartyViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let party = self.party {
      return party.menu.conso?.count ?? 1
    }
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let party = self.party, let conso = party.menu.conso {
      let cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifer)
      cell.textLabel?.text = conso[indexPath.row].name
      let price = String(format: "%.02f €", conso[indexPath.row].price ?? -1)
      cell.detailTextLabel?.text = price
      cell.selectionStyle = .none
      cell.backgroundColor = UIColor(hex: 0x363D4C)
      cell.textLabel?.textColor = UIColor(hex: 0xE88B26)
      cell.detailTextLabel?.textColor = UIColor(hex: 0xE88B26)
      return cell
    }
    let cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifer)
    cell.textLabel?.text = "Menu indisponible :("
    cell.backgroundColor = UIColor(hex: 0x363D4C)
    cell.textLabel?.textColor = UIColor(hex: 0xE88B26)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if hasJoin {
      if let party = self.party, let conso = party.menu.conso {
        let price = Int((conso[indexPath.row].price ?? -1) * 100)
        Basket.manager.addConsommableToOrder(consommableID: conso[indexPath.row].id)
        Basket.manager.incrementTotalPrice(price: price)
      }
    } else {
      let snackBar = TTGSnackbar(message: "Avant de commander, n'oublie pas de rejoindre la soirée !", duration: .long)
      snackBar.show()
    }
  }
  
}







