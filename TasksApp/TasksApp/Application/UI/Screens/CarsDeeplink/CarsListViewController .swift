//
//  CarsListViewController .swift
//  TasksApp
//
//  Created by user on 30.05.2024.
//

import UIKit
import SnapKit

final class CarsListViewController: UIViewController {
    
    var onSelectedCar: OnSelectedCar?
    
    private lazy var tableView = UITableView()
    private let carsList: [Car] = Cars().listOfAll
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.reuseId)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
    }
}

extension CarsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = carsList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseId, for: indexPath) as? CarTableViewCell else {
            fatalError("The TableView could not dequeue a CountryListTableViewCell in ViewController.")
        }
        
        cell.configureCell(with: car)
        return cell
    }
}

extension CarsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let car = carsList[indexPath.row]
        onSelectedCar?(car)
    }
}
