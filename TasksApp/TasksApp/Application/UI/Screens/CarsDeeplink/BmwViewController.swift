//
//  CarViewController.swift
//  TasksApp
//
//  Created by user on 29.05.2024.
//

import UIKit

final class BmwViewController: UIViewController {

    override func loadView() {
        let bmw = Bmw()
        let carView = CarView()
        carView.configureCatInfo(bmw)
        self.view = carView
        view.backgroundColor = .white
    }
}
