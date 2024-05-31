//
//  HomeViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(homeImageView)
        
        homeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(200)
        }
    }
}
