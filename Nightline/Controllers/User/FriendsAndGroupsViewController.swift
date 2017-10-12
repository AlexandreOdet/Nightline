//
//  FriendsAndGroupsViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 12/10/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

enum Mode {
    case friends, groups
}

class FriendsAndGroupsViewController: UIViewController {
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var mode: Mode = .friends {
        didSet {
            switch mode {
            case .friends:
                tableView.reloadData()
            case .groups:
                tableView.reloadData()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changedMode(_ sender: Any) {
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
