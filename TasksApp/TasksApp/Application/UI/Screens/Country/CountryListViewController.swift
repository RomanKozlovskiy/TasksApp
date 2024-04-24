//
//  Task2ViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit
import SnapKit

final class CountryListViewController: UIViewController {
    private let countriesProvider: CountriesProvider
    private var countries: [Country] = []
    private var nextPagePath: String?
    
    var onSelectedCountry: OnSelectedCountry?
    
    private var navigationBarIsHidden = false {
        didSet {
            navigationController?.setNavigationBarHidden(navigationBarIsHidden, animated: true)
        }
    }
    
    private lazy var tableView = UITableView()
    
    init(countriesProvider: CountriesProvider) {
        self.countriesProvider = countriesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        addSubviews()
        applyConstraints()
        configureTableView()
        fetchCountries()
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

    private func fetchCountries() {
        countriesProvider.fetchCountries { countryList in
            guard let countryList else { return }
            self.countries = countryList.countries
            self.nextPagePath = countryList.next
            self.tableView.reloadData()
        }
    }
}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryListTableViewCell else {
            fatalError("The TableView could not dequeue a CountryListTableViewCell in ViewController.")
        }
        cell.accessoryType = .disclosureIndicator
        let country = countries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if navigationController?.isNavigationBarHidden == true {
            navigationBarIsHidden = false
        }
        let country = countries[indexPath.row]
        onSelectedCountry?(country)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
       if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
           navigationBarIsHidden = true
       } else {
           navigationBarIsHidden = false
       }
    }
}
