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
    var parties: [Party] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getPartyInfos()
        // Do any additional setup after loading the view.
    }

    func getPartyInfos() {
        firstly {
            estabInstance.getEstablishmentParties(idEstablishment: bar_id)
            }.then { result -> Void in
                self.parties = result
                print(self.parties)
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
