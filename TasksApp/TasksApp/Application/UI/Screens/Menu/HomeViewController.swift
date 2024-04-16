//
//  HomeViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapButtonMenu()
}

final class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = Constants.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageSystemName),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(barButtonTapped))
    }
    
    @objc private func barButtonTapped() {
        delegate?.didTapButtonMenu()
    }
}

private extension HomeViewController {
    enum Constants {
        static let title = "Home"
        static let imageSystemName = "list.dash"
    }
}
