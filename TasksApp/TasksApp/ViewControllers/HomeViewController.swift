//
//  HomeViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTappedButtonMenu()
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        title = Constants.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.imageSystemName),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(barButtonTapped))
    }
    
    @objc private func barButtonTapped() {
        delegate?.didTappedButtonMenu()
    }
}

private extension HomeViewController {
    enum Constants {
        static let title = "Home"
        static let imageSystemName = "list.dash"
    }
}
