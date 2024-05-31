//
//  CarsTableViewCell.swift
//  TasksApp
//
//  Created by user on 30.05.2024.
//

import UIKit
import SnapKit

final class CarTableViewCell: UITableViewCell {
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let carNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with car: Car) {
        carImageView.image = car.carLogo
        carNameLabel.text = car.carBrand.rawValue    }
    
    private func configureUI() {
        addSubview(carImageView)
        addSubview(carNameLabel)
        
        carImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(150)
            $0.top.bottom.equalToSuperview()
        }
        
        carNameLabel.snp.makeConstraints {
            $0.leading.equalTo(carImageView.snp.trailing).offset(10)
            $0.top.bottom.trailing.equalToSuperview().inset(10)
        }
    }
}
