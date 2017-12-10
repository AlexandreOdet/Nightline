//
//  AppDelegate.swift
//  Nightline
//
//  Created by Odet Alexandre on 02/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import UIKit
import SwiftyBeaver
import KeychainSwift
import FBSDKCoreKit
import PromiseKit
import Stripe

let log = SwiftyBeaver.self
let tokenWrapper = TokenWrapper()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let console = ConsoleDestination()
    log.addDestination(console)
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = UIColor.black
    navigationBarAppearace.barTintColor = UIColor.orange
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let nav1 = UINavigationController()
    let mainView = TabBarController()
    nav1.viewControllers = [mainView]
    self.window!.rootViewController = nav1
    self.window?.makeKeyAndVisible()
    UIApplication.shared.statusBarStyle = .lightContent
//    let idUser = UserManager.instance.retrieveUserId()
//    if idUser > -1 {
//      firstly {
//        RAUser().getUserInfos(id: String(idUser))
//        }.then { response -> Void in
//          if let user = response.user {
//            UserManager.instance.initDbUser(userFromApi: user)
//          }
//        }.catch { _ in
//          return
//      }
//      firstly {
//        RAGroup().createGroup(groupName: "Super groupe :)", groupDescription: "Hé hé il semblerait que je puisse créer un groupe depuis une super app iOS")
//        }.then { groupReponse -> Void in
//          print(groupReponse.toJSON())
//          if let groupId = groupReponse.group.id {
//            firstly {
//                RAGroup().getGroupInformations(groupId: groupId)
//              }.then { groupResponse -> Void in
//                print(groupResponse.toJSON())
//              }.catch { _ in
//                print("Impossible d'accéder aux infos du groupe.")
//            }
//          }
//        }.catch { _ in
//          print("Oh non, une erreur malveillante s'est immissée entre ton code et le serveur :'(")
//      }
//    }
    let userDefaults = UserDefaults.standard
    
    if userDefaults.bool(forKey: "hasRunBefore") == false {
      tokenWrapper.deleteToken()
      userDefaults.set(true, forKey: "hasRunBefore")
      userDefaults.synchronize()
    }
    FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    STPPaymentConfiguration.shared().publishableKey = AppConstant.StripeToken.publishableKey
    return true
  }

  @objc func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
  }
}

