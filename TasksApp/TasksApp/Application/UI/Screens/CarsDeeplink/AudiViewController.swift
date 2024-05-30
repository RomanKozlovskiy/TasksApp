//
//  AudiViewController.swift
//  TasksApp
//
//  Created by user on 29.05.2024.
//

import UIKit

final class AudiViewController: UIViewController {

    override func loadView() {
        let audi = Audi()
        let carView = CarView()
        carView.configureCatInfo(audi)
        self.view = carView
        view.backgroundColor = .white
    }
}
