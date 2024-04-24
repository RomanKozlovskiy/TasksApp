//
//  CountryListTableViewCell.swift
//  TasksApp
//
//  Created by user on 19.04.2024.
//

import UIKit
import SnapKit

final class CountryListTableViewCell: UITableViewCell {
    private lazy var labelsStackView = UIStackView()
    private lazy var horizontalStackView = UIStackView()
    private lazy var verticalStackView = UIStackView()
    
    private lazy var flagImage: UIImageView = {
        let flagImage = UIImageView()
        flagImage.clipsToBounds = true
        flagImage.contentMode = .scaleAspectFit
        flagImage.image = UIImage(resource: .noFlag)
        return flagImage
    }()
    
    private lazy var countryName: UILabel = {
        let countryName = UILabel()
        countryName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        countryName.textAlignment = .left
        return countryName
    }()
    
    private lazy var capitalName: UILabel = {
        let capitalName = UILabel()
        capitalName.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        capitalName.textColor = .systemGray
        capitalName.textAlignment = .left
        return capitalName
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        flagImage.image = nil
        countryName.text = nil
        capitalName.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(with country: Country) {
       // flagImage.load(stringUrl: country.countryInfo.flag)
        countryName.text = country.name
        capitalName.text = country.capital
        descriptionLabel.text = country.descriptionSmall
    }
    
    func loadImage(from stringUrl: String, completion: @escaping (UIImage) -> Void) {
        flagImage.load(stringUrl: stringUrl) { image in
            completion(image)
        }
    }
    
    func set(_ image: UIImage) {
        flagImage.image = image
    }
    
    private func addSubviews() {
        addSubview(verticalStackView)
    }
    
    private func applyConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        flagImage.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(50)
        }
    }
    
    private func configureStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 0
        labelsStackView.addArrangedSubview(countryName)
        labelsStackView.addArrangedSubview(capitalName)
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.spacing = 10
        horizontalStackView.addArrangedSubview(flagImage)
        horizontalStackView.addArrangedSubview(labelsStackView)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 5
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
}
