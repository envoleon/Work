//
//  AppDelegate.swift
//  Currency Converter
//
//  Created by Александр Лебедев on 25.07.2022.
//

import UIKit

var baseSize: BaseSize?
var scaleWidth: CGFloat?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        baseSize = BaseSize((self.window?.frame.width)!)
        scaleWidth = (self.window?.frame.width ?? 0) / Double(baseSize!.width)

        window?.rootViewController = LoadViewController()

        window?.makeKeyAndVisible()
        return true
    }

}
