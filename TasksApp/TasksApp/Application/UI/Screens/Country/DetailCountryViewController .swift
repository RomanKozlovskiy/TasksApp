//
//  DetailCountryViewController .swift
//  TasksApp
//
//  Created by user on 22.04.2024.
//

import UIKit
import SnapKit

final class DetailCountryViewController: UIViewController {
    private var country: Country
    private var collectionView: UICollectionView!
    private var currentPage = 0
    private var images: [UIImage] = []
    
    private let detailCountryProvider: DetailCountryProvider
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.tintColor = .lightGray
        return pageControl
    }()
     
    init(detailCountryProvider: DetailCountryProvider, country: Country) {
        self.detailCountryProvider = detailCountryProvider
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        addSubviews()
        applyConstraints()
        configureBottomSheet()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.dismiss(animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
    }
    
    private func applyConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.screenWidth / 2)
            
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(collectionView.snp.bottom).inset(30)
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailCountryCollectionViewCell.self, forCellWithReuseIdentifier: DetailCountryCollectionViewCell.reuseId)
    }
    
    private func configureBottomSheet() {
        let countrySheetController = UINavigationController(rootViewController: CountryBottomSheetController())
        if let sheet = countrySheetController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        countrySheetController.isModalInPresentation = true
        navigationController?.present(countrySheetController, animated: true)
        if let viewController = countrySheetController.viewControllers.first as? CountryBottomSheetController {
            viewController.configureUI(with: country)
        }
    }
    
    private func configureUI() {
        pageControl.numberOfPages = country.countryInfo.images.count
    }
}

extension DetailCountryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        !country.countryInfo.images.isEmpty ? country.countryInfo.images.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCountryCollectionViewCell.reuseId, for: indexPath) as! DetailCountryCollectionViewCell
        
        if let image = detailCountryProvider.getCachedObject(for: indexPath.row as AnyObject) {
            cell.setImage(image: image)
        } else if !country.countryInfo.images.isEmpty {
            let imageUrl = country.countryInfo.images[indexPath.row]
            cell.configure(with: imageUrl) { [weak self] image in
                cell.setImage(image: image)
                self?.detailCountryProvider.setCachedObject(image: image, key: indexPath.row as AnyObject)
            }
        } else if country.image != ""  {
            let imageUrl = country.image
            cell.configure(with: imageUrl) { [weak self] image in
                cell.setImage(image: image)
                self?.detailCountryProvider.setCachedObject(image: image, key: indexPath.row as AnyObject)
            }
        } else {
            let imageUrl = country.countryInfo.flag
            cell.configure(with: imageUrl) { [weak self] image in
                cell.setImage(image: image)
                self?.detailCountryProvider.setCachedObject(image: image, key: indexPath.row as AnyObject)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}

private extension DetailCountryViewController {
    enum Constants {
        static let screenWidth = UIScreen.main.bounds.height
    }
}
