//
//  SceneDelegate.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coverView: CoverView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = ContainerViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        coverView = CoverView()
        if let coverView = coverView, let window = window {
            coverView.frame = window.frame
            window.addSubview(coverView)
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        coverView?.removeFromSuperview()
        coverView = nil
    }
}
