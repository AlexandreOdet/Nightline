//
//  DetailPartyViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class DetailPartyViewController: UIViewController {
    var bar_id = ""
    let estabInstance = RAEtablissement()
    var party: Party?
    var menu: Menu?

    @IBOutlet weak var partyView: UIView!
    @IBOutlet weak var noParty: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getPartyInfos()
        // Do any additional setup after loading the view.
    }

    func setView() {
        if party != nil {
            noParty.isHidden = true
            partyView.isHidden = false
            descLabel.text = party?.description
            startLabel.text = party?.begin
            endLabel.text = party?.end
            menu = party?.menu
        } else {
            noParty.isHidden = false
            partyView.isHidden = true
        }
    }

    func getPartyInfos() {
        firstly {
            estabInstance.getEstablishmentParties(idEstablishment: bar_id)
            }.then { result -> Void in
                self.party = result.party
                DispatchQueue.main.async {
                    self.setView()
                }
            }.catch { error -> Void in
                print(error)
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
