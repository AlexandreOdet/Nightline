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

final class MainViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  static let notificationIdentifier = "presentConnexionScreen"
  
  var map = MKMapView()
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if (tokenWrapper.getToken() == nil) {
      self.present(HomeViewController(), animated: true, completion: nil)
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
      }
    }
    NotificationCenter.default.addObserver(self, selector: #selector(callbackObserver), name: NSNotification.Name(rawValue: MainViewController.notificationIdentifier), object: nil)
  }
  
  func requestLocationAccess() {
    let status = CLLocationManager.authorizationStatus()
    
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      return
      
    case .denied, .restricted:
      print("location access denied")
      
    default:
      self.locationManager.requestWhenInUseAuthorization()
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
        pinView?.tag = 1
      }
      else {
        pinView?.annotation = annotation
      }
      return pinView
    }
    return nil
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard view.tag == 1 else {
      return
    }
    let actionList = UIAlertController(title: "", message: "Comment souhaitez-vous vous y rendre?", preferredStyle: .actionSheet)
    actionList.addAction(UIAlertAction(title: "Voitures", style: .default, handler: nil))
    actionList.addAction(UIAlertAction(title: "A Pied", style: .default, handler: nil))
    actionList.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
    self.present(actionList, animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addMarkerToMap()
  }
  
  private func addMarkerToMap() {
    //let GML = CLLocationCoordinate2DMake(42.328994, -83.039708)
    let unionSquare = CLLocationCoordinate2DMake(37.78806, -122.4075)
    let marker = Marker(title: "Union Square",
                        locationName: "San Francisco Union Square",
                        discipline: "",
                        coordinate: unionSquare)
    self.map.addAnnotation(marker)
  }
  
  func callbackObserver() {
    self.present(HomeViewController(), animated: true, completion: nil)
  }
  
}
