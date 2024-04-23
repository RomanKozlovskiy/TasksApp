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
        imageView.image = UIImage(systemName: "pencil.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
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
}
