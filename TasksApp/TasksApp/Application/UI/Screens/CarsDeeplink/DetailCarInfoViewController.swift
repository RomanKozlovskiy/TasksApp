//
//  DetailCarInfoViewController.swift
//  TasksApp
//
//  Created by user on 30.05.2024.
//

import UIKit

final class DetailCarInfoViewController: UIViewController {
    private let car: CarInfoProtocol
    
    init(car: CarInfoProtocol) {
        self.car = car
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let carLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let carDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(carLogo)
        view.addSubview(carDescription)
        
        carLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
            $0.width.equalToSuperview().inset(10)
        }
        
        carDescription.snp.makeConstraints {
            $0.top.equalTo(carLogo.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        carLogo.image = car.carLogo
        carDescription.text = car.carDescription
    }
}
