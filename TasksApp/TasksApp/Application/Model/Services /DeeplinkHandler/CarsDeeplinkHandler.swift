//
//  CarsDeeplinkHandler.swift
//  TasksApp
//
//  Created by user on 30.05.2024.
//

import UIKit

final class CarsDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var rootViewController: UINavigationController?
    private var viewController: UIViewController?
    
    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
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
            viewController = AudiViewController()
        default:
            viewController = BmwViewController()
        }
        
        if viewController != nil {
            rootViewController?.popToRootViewController(animated: true)
            rootViewController?.pushViewController(viewController!, animated: true)
        }
    }
}
