//
//  AppDelegate.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 25.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    private var baseSize = BaseSize.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        baseSize.initScale((self.window?.frame.width)!)

        window?.rootViewController = LoadViewController()

        window?.makeKeyAndVisible()
        return true
    }

}
