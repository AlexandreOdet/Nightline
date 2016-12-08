//
//  MainViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MapKit

class HomeViewController: BaseViewController {
  
  var map = MKMapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestLocationAccess()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.addSubview(map)
      map.snp.makeConstraints { (make) -> Void in
        make.edges.equalTo(self.view)
      }
      map.showsUserLocation = true
      let rightBarButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(goToUserProfileViewController))
      self.navigationItem.rightBarButtonItem = rightBarButton
    }
  }
  
  func goToUserProfileViewController() {
    self.navigationController?.pushViewController(UserProfileViewController(), animated: true)
  }
  
  func requestLocationAccess() {
    let status = CLLocationManager.authorizationStatus()
    
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      return
      
    case .denied, .restricted:
      print("location access denied")
      
    default:
      PermissionManager.sharedInstance.locationManager.requestWhenInUseAuthorization()
    }
  }
  
}
