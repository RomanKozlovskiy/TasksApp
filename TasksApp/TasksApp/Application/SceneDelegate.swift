//
//  SceneDelegate.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var coverView: CoverView?
    private let appFactory: AppFactory = Di()
    private var coordinator: Coordinator?
    
    lazy var deeplinkCoordinator: DeeplinkCoordinatorProtocol = DeeplinkCoordinator(handlers: [
        CarsDeeplinkHandler(rootViewController: rootViewController)
    ]
    )
    
    var rootViewController: UINavigationController? {
        return window?.rootViewController as? UINavigationController
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        runUI(windowScene: windowScene)
    }
    
    private func runUI(windowScene: UIWindowScene) {
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator(windowScene: windowScene)
        self.window = window
        self.coordinator = coordinator
        window.makeKeyAndVisible()
        coordinator.start()
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
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let firstUrl = URLContexts.first?.url else {
            return
        }
        deeplinkCoordinator.handleURL(firstUrl)
    }
}
