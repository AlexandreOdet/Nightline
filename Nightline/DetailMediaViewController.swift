//
//  DetailMediaViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 23/07/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class DetailMediaViewController: UIViewController {

  let imageView = UIImageView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.addSubview(imageView)
      imageView.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
      }
        // Do any additional setup after loading the view.
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
