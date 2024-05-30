//
//  CarView .swift
//  TasksApp
//
//  Created by user on 29.05.2024.
//

import UIKit
import SnapKit

final class CarView: UIView {
     let carLogo: UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCatInfo(_ car: CarInfoProtocol) {
        carLogo.image = car.carLogo
        carDescription.text = car.carDescription
    }
    
    private func configureUI() {
        addSubview(carLogo)
        addSubview(carDescription)
        
        carLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
            $0.height.equalTo(200)
            $0.width.equalToSuperview()
        }
        carDescription.snp.makeConstraints {
            $0.top.equalTo(carLogo.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
