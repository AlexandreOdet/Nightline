//
//  EditFirstNameViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 13/04/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift

class EditAgeViewController: BaseViewController {

    let contentView = UIView()
    let editLabel = UILabel()
    let datePicker = UIDatePicker()

    func setupView() {
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
            make.left.right.bottom.equalTo(self.view)
        }
        self.contentView.addSubview(editLabel)
        editLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
            make.height.equalTo(30)
        }
        self.view.backgroundColor = self.backgroundColor()
        editLabel.text = "Date de naissance :"
        editLabel.textColor = self.labelTextColor()
        self.contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(editLabel.snp.bottom).offset(20)
            make.right.left.equalTo(self.contentView)
            make.height.equalTo(self.contentView).dividedBy(2)
        }
        setDatePicker()
    }

    func setDatePicker() {
        datePicker.calendar = Calendar.current
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if let actualUserBD = UserManager.instance.getBirthDate() {
            datePicker.setDate(actualUserBD, animated: true)
        } else {
            let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
            datePicker.setDate(date!, animated: true)
        }
        datePicker.backgroundColor = self.backgroundColor()
        datePicker.tintColor = .orange
        datePicker.setValue(UIColor.orange, forKeyPath: "textColor")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        UserManager.instance.updateUserAge(newValue: datePicker.date)
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
