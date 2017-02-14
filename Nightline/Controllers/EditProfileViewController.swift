//
//  EditProfileViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {

    let tableView = UITableView()
    let userProfilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
    let headerView = UIView()
    let userInfoStackView = UIStackView()
    let userNameLabel = UILabel()
    let userLastNameLabel = UILabel()
    let ageLabel = UILabel()
    let cityLabel = UILabel()
    let userName = UITextField()
    let userLastName = UITextField()
    let age = UITextField()
    let city = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if Utils.Network.isInternetAvailable() == false {
            self.showNoConnectivityView()
        } else {
            self.view.backgroundColor = UIColor.black
            self.addComponentsToView()
            let rightBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(comeBackToProfileViewController))
            //rightBarButton.tintColor = UIColor.orange
            self.navigationItem.rightBarButtonItem = rightBarButton
        }

    }

    private func addComponentsToView() {
        initHeaderView()
        addUserProfilePicture()
        addUserNameLabels()
    }
    
    private func initHeaderView() {
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
            make.height.equalTo(UIScreen.main.bounds.width)
//            make.height.equalTo(UIScreen.main.bounds.width * (9/16))
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = self.getMidnightBlue()
    }
    
    private func addUserProfilePicture() {
        self.headerView.addSubview(userProfilePicture)
        userProfilePicture.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.headerView)
            make.leading.equalTo(self.headerView).offset(15)
            make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
        }
        userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
        userProfilePicture.roundImage()
        userProfilePicture.image = R.image.logo()
    }
    
    private func addUserNameLabels() {
        self.headerView.addSubview(userInfoStackView)
        userInfoStackView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.headerView.snp.centerX)
            make.trailing.equalTo(self.headerView).offset(-10)
            make.centerY.equalTo(headerView)
        }
        userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        userInfoStackView.axis = .vertical
        userInfoStackView.spacing = 10
        
        userNameLabel.text = "First name:"
        userLastNameLabel.text = "Last name:"
        ageLabel.text = "Age:"
        cityLabel.text = "City:"
        
        userName.text = "Cédric"
        userLastName.text = "Moreaux"
        age.text = "22"
        city.text = "Shanghai"
        
        userNameLabel.textColor = self.getAccentColor()
        userNameLabel.textAlignment = .left
        userName.textColor = self.getAccentColor()
        userName.styleEditField()
        userLastNameLabel.textColor = self.getAccentColor()
        userLastNameLabel.textAlignment = .left
        userLastName.textColor = self.getAccentColor()
        userLastName.styleEditField()
        ageLabel.textColor = self.getAccentColor()
        ageLabel.textAlignment = .left
        age.textColor = self.getAccentColor()
        age.styleEditField()
        age.keyboardType = UIKeyboardType.numberPad
        cityLabel.textColor = self.getAccentColor()
        cityLabel.textAlignment = .left
        city.textColor = self.getAccentColor()
        city.styleEditField()
        userInfoStackView.addArrangedSubview(userNameLabel)
        userInfoStackView.addArrangedSubview(userName)
        userInfoStackView.addArrangedSubview(userLastNameLabel)
        userInfoStackView.addArrangedSubview(userLastName)
        userInfoStackView.addArrangedSubview(ageLabel)
        userInfoStackView.addArrangedSubview(age)
        userInfoStackView.addArrangedSubview(cityLabel)
        userInfoStackView.addArrangedSubview(city)
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
    func comeBackToProfileViewController() {
        let nextViewController = UserProfileViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }


}
