//
//  ApplicationCoordinator.swift
//  TasksApp
//
//  Created by user on 16.04.2024.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
       runMenuScreen()
    }
    
    private func runMenuScreen() {
        let coordinator = coordinatorFactory.makeMenuCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
