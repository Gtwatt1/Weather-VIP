//
//  SceneDelegate.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 23/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
       setupInitialViewController(scene)
    }

    private func setupInitialViewController(_ scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            let initialVC = WeatherBuilder().build()
            self.window = UIWindow(windowScene: windowScene)
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
        }
    }
}
