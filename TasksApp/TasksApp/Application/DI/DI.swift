//
//  DI.swift
//  TasksApp
//
//  Created by user on 16.04.2024.
//

import UIKit

final class Di {
    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactory
    
    init() {
        self.screenFactory = ScreenFactory()
        self.coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        self.screenFactory.di = self
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene) -> (UIWindow, Coordinator)
}

extension Di: AppFactory {
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene) -> (UIWindow, Coordinator) {
        let window = UIWindow(windowScene: windowScene)
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

final class ScreenFactory {
    fileprivate weak var di: Di!
    
    fileprivate init() {}
    
    func makeMenuScreen() -> ContainerViewController {
        return ContainerViewController()
    }
}

final class CoordinatorFactory {
    private let screenFactory: ScreenFactory
    
    fileprivate init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeMenuCoordinator(router: Router) -> MenuCoordinator {
        MenuCoordinator(router: router, screenFactory: screenFactory)
    }
}
