//
//  CarsDeeplinkHandler.swift
//  TasksApp
//
//  Created by user on 30.05.2024.
//

import UIKit

final class CarsDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var navigationController: UINavigationController?
    private var viewController: UIViewController?
    
    init(rootViewController: UINavigationController?) {
        self.navigationController = rootViewController
    }
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString.hasPrefix("taskapp://cars")
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        switch url.path {
        case "/audi":
            viewController = DetailCarInfoViewController(car: Cars.audi)
        case "/bmw":
            viewController = DetailCarInfoViewController(car: Cars.bmw)
        default:
            viewController = DetailCarInfoViewController(car: Cars.mercedes)
        }
        
        guard
            let navigationController,
            let viewController else {
            return
        }

        popToHomeViewController(navigationController: navigationController)
        
        let carsList = CarsListViewController()
        navigationController.pushViewController(carsList, animated: true)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func popToHomeViewController(navigationController: UINavigationController) {
        if navigationController.viewControllers.count > 1 {
           
            if let containerVC = navigationController.viewControllers.first,
                let homeViewController = containerVC.children.first(where: { $0 is HomeViewController}) {
       
                homeViewController.view.subviews.forEach { subview in
                    if !(subview is UIImageView) {
                        subview.removeFromSuperview()
                    }
                }
                
                containerVC.addChild(homeViewController)
                containerVC.view.addSubview(homeViewController.view)
                homeViewController.view.frame = containerVC.view.frame
                homeViewController.didMove(toParent: containerVC)
                containerVC.title = homeViewController.title
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
}
