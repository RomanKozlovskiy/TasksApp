//
//  Task2ViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit
import SnapKit

final class CountryListViewController: UIViewController {
    var onSelectedCountry: OnSelectedCountry?
    
    var navigationBarIsHidden = false {
        didSet {
            navigationController?.setNavigationBarHidden(navigationBarIsHidden, animated: true)
        }
    }
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Countries"
        addSubviews()
        applyConstraints()
        configureTableView()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func applyConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryListTableViewCell else {
            fatalError("The TableView could not dequeue a CountryListTableViewCell in ViewController.")
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if navigationController?.isNavigationBarHidden == true {
            navigationBarIsHidden = false
        }
        onSelectedCountry?(indexPath.row) //TODO: - заменить на model Country
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
           navigationBarIsHidden = true
       } else {
           navigationBarIsHidden = false
       }
    }
}
