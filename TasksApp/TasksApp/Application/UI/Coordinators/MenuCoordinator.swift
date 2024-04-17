//
//  MenuCoordinator.swift
//  TasksApp
//
//  Created by user on 16.04.2024.
//

import Foundation

final class MenuCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        makeMenu()
    }
    
    private func makeMenu() {
        let menuScreen = screenFactory.makeMenuScreen()
        
        menuScreen.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(menuScreen, hideBar: true)
    }
}
