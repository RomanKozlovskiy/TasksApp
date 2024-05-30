//
//  MenuCoordinator.swift
//  TasksApp
//
//  Created by user on 16.04.2024.
//

import Foundation

final class MenuCoordinator: BaseCoordinator {
    var finishFlow: VoidClosure?
    
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
        let menuContainerScreen = screenFactory.makeMenuScreen()
        
        menuContainerScreen.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(menuContainerScreen)
        
        menuContainerScreen.onSelectedCountry = { [weak self] country in
            self?.makeDetailCountry(with: country)
        }
        
        menuContainerScreen.onSelectedCar = { [weak self] car in
            self?.makeDetailCarInfo(with: car)
        }
    }
    
    private func makeDetailCountry(with country: Country) {
        let detailCountryScreen = screenFactory.makeDetailCountryScreen(with: country)
        router.push(detailCountryScreen)
    }
    
    private func makeDetailCarInfo(with car: CarInfoProtocol) {
        let detailCarScree = screenFactory.makeDetailCarScreen(with: car)
        router.push(detailCarScree)
    }
}
