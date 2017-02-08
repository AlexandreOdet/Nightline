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

class HomeViewController: BaseViewController, CLLocationManagerDelegate {
  
  var map = MKMapView()
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if (keychain.get("token") == nil) {
      self.present(MainViewController(), animated: true, completion: nil)
    } else {
      requestLocationAccess()
      if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
      }
      if Utils.Network.isInternetAvailable() == false {
        self.showNoConnectivityView()
      } else {
        self.view.addSubview(map)
        map.snp.makeConstraints { (make) -> Void in
          make.edges.equalTo(self.view)
        }
        map.showsUserLocation = true
        map.isZoomEnabled = true
        let rightBarButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(goToUserProfileViewController))
        self.navigationItem.rightBarButtonItem = rightBarButton
      }
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
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last! as CLLocation
    
    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    self.map.setRegion(region, animated: true)
  }
}
