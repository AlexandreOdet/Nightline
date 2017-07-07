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
import PromiseKit

/*
 Controllers: MainViewController
 This controller is the main one, when user launches the app it starts here.
 Containing the Map with all the pins around user location.
 */

final class MainViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  static let notificationIdentifier = "presentConnexionScreen"
  
  var map = MKMapView()
  let locationManager = CLLocationManager()
  var restApiUser = RAUser()
  var restApiEtablishment = RAEtablissement()
  
  deinit {
    restApiUser.cancelRequest()
    restApiEtablishment.cancelRequest()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    AchievementManager.instance.initUserAchievementArray()
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
        addFiltersToMap()
      }
    }
    NotificationCenter.default.addObserver(self, selector: #selector(callbackObserver), name: NSNotification.Name(rawValue: MainViewController.notificationIdentifier), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(connexionOK), name: NSNotification.Name(rawValue: SigninViewController.notificationIdentifier), object: nil)
    log.verbose("\(FilterManager.instance.toParameters())")
  }
  
  /*
   requestLocationAccess() function
   This function asks user's permission to access his location when he uses the app.
   @param None
   @return None
   */
  
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
    
    // Enlevé pour centrer la carte pour la beta
//    let location = locations.last! as CLLocation
    
//    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    let center = CLLocationCoordinate2D(latitude: 48.8517, longitude: 2.3477)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    self.map.setRegion(region, animated: true)
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "pin"
    log.debug("\(String(describing: annotation.title))")
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
    actionList.addAction(UIAlertAction(title: "Accéder à la fiche du bar", style: .default, handler: { action in
      self.tabBarController?.navigationController?.pushViewController(EtablishmentViewController(), animated: true)
    }))
    actionList.addAction(UIAlertAction(title: "Voitures", style: .default, handler: nil))
    actionList.addAction(UIAlertAction(title: "A Pied", style: .default, handler: nil))
    actionList.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
    self.present(actionList, animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    firstly {
      restApiEtablishment.getEtablishmentList()
      }.then { array -> Void in
        for item in array {
          print("name: \(item.name)", "Latitude: \(item.latitude)", "Longitude: \(item.longitude)")
          
        }
        for item in array {
          let coordinates = CLLocationCoordinate2DMake(CLLocationDegrees(item.latitude),
                                                       CLLocationDegrees(item.longitude)) // ou (item.long, item.lat)
          let marker = Marker(title: item.name,
                              locationName: "",
                              discipline: "",
                              coordinate: coordinates)
          self.map.addAnnotation(marker)
        }
      }.catch { error in
        print("Error = ", error)
    }
  }
  
  /*
   callbackObserver() func
   This function is called when the observer subscribed in the viewDidLoad() method is called.
   It will present the HomeViewController().
   @param None
   @return None
   */
  
  func callbackObserver() {
    self.present(HomeViewController(), animated: true, completion: nil)
  }
  
  func connexionOK() {
    self.presentedViewController?.dismiss(animated: true, completion: nil)
  }
  
  private func addFiltersToMap() {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 15
    let grouplabel = UILabel()
    let eventLabel = UILabel()
    let personLabel = UILabel()

    let groupGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentGroupFilter))
    groupGestureRecognizer.numberOfTapsRequired = 1
    
    let eventGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentEventFilter))
    eventGestureRecognizer.numberOfTapsRequired = 1
    
    let personGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentPersonFilter))
    personGestureRecognizer.numberOfTapsRequired = 1
    
    personGestureRecognizer.numberOfTapsRequired = 1
    
    self.view.addSubview(stackView)
    stackView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + 5)
      make.width.equalTo(self.view)
      make.height.equalTo(50)
    }
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = UIColor.white
    
    grouplabel.text = "Groupes"
    grouplabel.isUserInteractionEnabled = true
    grouplabel.addGestureRecognizer(groupGestureRecognizer)
    grouplabel.textAlignment = .center
    grouplabel.backgroundColor = .white
    
    eventLabel.text = "Évènements"
    eventLabel.isUserInteractionEnabled = true
    eventLabel.addGestureRecognizer(eventGestureRecognizer)
    eventLabel.textAlignment = .center
    eventLabel.backgroundColor = .white
    
    personLabel.text = "Personnes"
    personLabel.isUserInteractionEnabled = true
    personLabel.addGestureRecognizer(personGestureRecognizer)
    personLabel.textAlignment = .center
    personLabel.backgroundColor = .white
    
    
    stackView.addArrangedSubview(grouplabel)
    stackView.addArrangedSubview(eventLabel)
    stackView.addArrangedSubview(personLabel)
  }
  
  func presentGroupFilter() {
    let alertSheetController = UIAlertController(title: "Filtres de groupe", message: nil, preferredStyle: .actionSheet)
    
    alertSheetController.addAction(UIAlertAction(title: GroupType.friend.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(groupType: GroupType.friend) {
        FilterManager.instance.remove(groupeType: GroupType.friend)
      } else {
        FilterManager.instance.add(groupeType: GroupType.friend)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: GroupType.brotherhood.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(groupType: GroupType.brotherhood) {
        FilterManager.instance.remove(groupeType: GroupType.brotherhood)
      } else {
        FilterManager.instance.add(groupeType: GroupType.brotherhood)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: GroupType.sisterhood.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(groupType: GroupType.sisterhood) {
        FilterManager.instance.remove(groupeType: GroupType.sisterhood)
      } else {
        FilterManager.instance.add(groupeType: GroupType.sisterhood)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil))
    
    self.present(alertSheetController, animated: true, completion: nil)
  }
  
  func presentEventFilter() {
    let alertSheetController = UIAlertController(title: "Filtres d'évènements", message: nil, preferredStyle: .actionSheet)
    
    alertSheetController.addAction(UIAlertAction(title: EventType.birthday.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(eventType: EventType.birthday) {
        FilterManager.instance.remove(eventType: EventType.birthday)
      } else {
        FilterManager.instance.add(eventType: EventType.birthday)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: EventType.festival.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(eventType: EventType.festival) {
        FilterManager.instance.remove(eventType: EventType.festival)
      } else {
        FilterManager.instance.add(eventType: EventType.festival)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil))
    
    self.present(alertSheetController, animated: true, completion: nil)
    
  }
  
  func presentPersonFilter() {
    let alertSheetController = UIAlertController(title: "Filtres de personne", message: nil, preferredStyle: .actionSheet)
    
    alertSheetController.addAction(UIAlertAction(title: PersonType.friend.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(personType: PersonType.friend) {
        FilterManager.instance.remove(personType: PersonType.friend)
      } else {
        FilterManager.instance.add(personType: PersonType.friend)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: PersonType.friendLink.toString(), style: .default, handler: { action in
      if FilterManager.instance.isItemInArray(personType: PersonType.friendLink) {
        FilterManager.instance.remove(personType: PersonType.friendLink)
      } else {
        FilterManager.instance.add(personType: PersonType.friendLink)
      }
    }))
    
    alertSheetController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil))
    
    self.present(alertSheetController, animated: true, completion: nil)
  }
}
