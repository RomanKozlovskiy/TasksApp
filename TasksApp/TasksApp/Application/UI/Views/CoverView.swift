//
//  CoverView.swift
//  TasksApp
//
//  Created by user on 08.04.2024.
//

import UIKit

final class CoverView: UIView {
    private let coverImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverImageView.frame = CGRect(x: 0, y: 0, width: Constants.imageViewWidth, height: Constants.imageViewHeight)
        coverImageView.center = center
    }
    
    private func configureImageView() {
        addSubview(coverImageView)
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
        coverImageView.image = UIImage(resource: .cover)
    }
}

private extension CoverView {
    enum Constants {
        static let imageViewWidth = 200
        static let imageViewHeight = 200
    }
}
