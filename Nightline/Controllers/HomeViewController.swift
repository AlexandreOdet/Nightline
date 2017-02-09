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

class HomeViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
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
        map.delegate = self
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
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "pin"
    log.debug("\(annotation.title)")
    if let annotation = annotation as? Marker {
      var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      if pinView == nil {
        pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinView!.canShowCallout = true
        pinView?.image = R.image.pin()
      }
      else {
        pinView?.annotation = annotation
      }
      return pinView
    }
    return nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addMarkerToMap()
  }
  
  private func addMarkerToMap() {
    let GML = CLLocationCoordinate2DMake(42.328994, -83.039708)
    let marker = Marker(title: "General Motors",
                        locationName: "Renaissance Center",
                        discipline: "",
                        coordinate: GML)
    self.map.addAnnotation(marker)
  }
}
