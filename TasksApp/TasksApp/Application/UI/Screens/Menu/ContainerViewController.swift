//
//  ContainerViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit

final class ContainerViewController: UIViewController {
    enum MenuState {
        case closed
        case opened
    }

    var onFinish: VoidClosure?
    var onSelectedCountry: OnSelectedCountry?
    
    private var menuState: MenuState = .closed
    
    private var menuViewController: MenuViewController!
    private var homeViewController: HomeViewController!
    private var weatherViewController: WeatherViewController!
    private var countryListViewController: CountryListViewController!
    private var task3ViewController: RichTextViewController!
    
    private var childControllers = [UIViewController]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureChildsControllers()
        configureGestures()
        
        countryListViewController.onSelectedCountry = { [weak self] country in
            self?.onSelectedCountry?(country)
        }
    }

     func addDependency(
        menuVC: MenuViewController,
        homeVC: HomeViewController,
        weatherVC: WeatherViewController,
        countryListVC: CountryListViewController,
        task3VC: RichTextViewController
    ) {
        self.menuViewController = menuVC
        self.homeViewController = homeVC
        self.weatherViewController = weatherVC
        self.countryListViewController = countryListVC
        self.task3ViewController = task3VC
    }
    
    private func configureChildsControllers() {
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMove(toParent: self)
        menuViewController.delegate = self
        
        addChild(homeViewController)
        view.addSubview(homeViewController.view)
        homeViewController.didMove(toParent: self)
    }
    
    private func configureGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(toggleMenu))
        swipeLeftGesture.direction = .left
        swipeLeftGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(toggleMenu))
        swipeRightGesture.direction = .right
        swipeRightGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeRightGesture)
    }
    
    private func open(_ task: UIViewController) {
        homeViewController.addChild(task)
        homeViewController.view.addSubview(task.view)
        task.view.frame = homeViewController.view.frame
        task.didMove(toParent: homeViewController)
        title = task.title
        childControllers.append(task)
    }
    
    private func resetToHome() {
        childControllers.forEach { taskVC in
            taskVC.view.removeFromSuperview()
            taskVC.didMove(toParent: nil)
        }
        title = Constants.title
    }
    
    @objc private func toggleMenu() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5,
                           delay: 0, usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                
                self.homeViewController.view.frame.origin.x = self.homeViewController.view.frame.size.width - 100
                self.homeViewController.view.backgroundColor = .lightGray
                
            } completion: { [weak self] _ in
                self?.menuState = .opened
            }
            
        case .opened:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                
                self.homeViewController?.view.frame.origin.x = 0
                self.homeViewController.view.backgroundColor = .white
            } completion: { [weak self] _ in
                self?.menuState = .closed
            }
        }
    }
    
    private func configureNavigationBar() {
        title = Constants.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.imageSystemName),
            style: .done,
            target: self,
            action: #selector(barButtonTapped)
        )
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        guard let navBar = navigationController?.navigationBar else {
            return 
        }
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
    }
    
    @objc private func barButtonTapped() {
        toggleMenu()
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu()
        
        switch menuItem {
        case .home:
            resetToHome()
        case .task1:
            open(weatherViewController)
        case .task2:
            open(countryListViewController)
        case .task3:
            open(task3ViewController)
        }
    }
}

private extension ContainerViewController {
    enum Constants {
        static let title = "Home"
        static let imageSystemName = "list.dash"
    }
}
