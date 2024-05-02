//
//  DetailCountryCollectionViewCell.swift
//  TasksApp
//
//  Created by user on 22.04.2024.
//

import UIKit
import SnapKit

final class DetailCountryCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(resource: .noFlag)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    func configure(with stringUrl: String, completion: @escaping (UIImage) -> Void) {
        imageView.downloadImage(stringUrl: stringUrl, completion: completion)
    }
}
