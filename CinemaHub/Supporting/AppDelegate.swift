//
//  AppDelegate.swift
//  CinemaHub
//
//  Created by Malcolm Kumwenda on 2017/06/19.
//  Copyright © 2017 Byte Orbit. All rights reserved.
//

import UIKit
import Hero

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupUI(application)
        return true
    }
    
    func setupUI(_ application: UIApplication){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        nav.isHeroEnabled = true
        nav.heroNavigationAnimationType = .zoom
        let mainView = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainVC")
        mainView.view.layer.cornerRadius = 3
        nav.viewControllers = [mainView]
        self.window!.rootViewController = nav
        self.window?.makeKeyAndVisible()
        application.statusBarStyle = .lightContent
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.clear
        navigationBarAppearace.barTintColor = UIColor.clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}

