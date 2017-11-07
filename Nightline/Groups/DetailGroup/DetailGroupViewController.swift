//
//  DetailGroupViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class DetailGroupViewController: UIViewController {
    let raGrp = RAGroup()
    let grpId = 0
    var grp: GroupResponse!
    let deepBlue = UIColor(hex: 0x0e1728)
    let lightBlue = UIColor(hex : 0x363D4C)
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersCV: UICollectionView!

    convenience init(grp: GroupResponse) {
        self.init()
        self.grp = grp
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(grp.id)
        print(grp.name)
        print(grp.owner.pseudo)
        setTheme()
        setData()
        // Do any additional setup after loading the view.
    }

    func setTheme() {
        mainView.backgroundColor = deepBlue
    }

    func setData() {
        nameLabel.text = grp.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
