//
//  AddUserCreditCardViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 14/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import Stripe

class AddUserCreditCardViewController: BaseViewController {
  
  let paymentAPI = RAPayment()
  
  deinit {
    paymentAPI.cancelRequest()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func createCardFromUserInfos() {
  }
  
  func sendTokenToApi() {
    paymentAPI.sendCardInfos(creditCardToken: "", user: UserManager.instance.networkUser, callbackError: {
      [weak self] in
      guard let strongSelf = self else { return }
      let alert = UIAlertController(title: "Erreur", message: "Oups il semble y avoir un problème avec ta carte !", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      alert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
      strongSelf.present(alert, animated: true, completion: nil)
    })
  }
}
