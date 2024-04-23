//
//  CountryBottomSheetController.swift
//  TasksApp
//
//  Created by user on 22.04.2024.
//

import UIKit
import SnapKit

final class CountryBottomSheetController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var capitalTitleLabel = createLabel(
        text: "Столица",
        textColor: .black,
        font: UIFont.systemFont(ofSize: 17, weight: .regular),
        numberOfLines: 1,
        textAlignment: .left
    )
    
    private lazy var populationTitleLabel = createLabel(
        text: "Население",
        textColor: .black,
        font: UIFont.systemFont(ofSize: 17, weight: .regular),
        numberOfLines: 1,
        textAlignment: .left
    )
    
    private lazy var continentTitleLabel = createLabel(
        text: "Континент",
        textColor: .black,
        font: UIFont.systemFont(ofSize: 17, weight: .regular),
        numberOfLines: 1,
        textAlignment: .left
    )
    
    private lazy var capitalInfoLabel = createLabel(
        text: "Москва",
        textColor: .systemGray,
        font: UIFont.systemFont(ofSize: 17, weight: .semibold),
        numberOfLines: 1,
        textAlignment: .right
    )
    
    private lazy var populationInfoLabel = createLabel(
        text: "1 000 000",
        textColor: .systemGray,
        font: UIFont.systemFont(ofSize: 17, weight: .semibold),
        numberOfLines: 1,
        textAlignment: .right
    )
    
    private lazy var continentInfoLabel = createLabel(
        text: "Континент",
        textColor: .systemGray,
        font: UIFont.systemFont(ofSize: 17, weight: .semibold),
        numberOfLines: 1,
        textAlignment: .right
    )
    
    private lazy var aboutLabel = createLabel(
        text: "О стране",
        textColor: .black,
        font: UIFont.systemFont(ofSize: 15, weight: .semibold),
        numberOfLines: 1,
        textAlignment: .left
    )
    
    private lazy var descriptionLabel = createLabel(
        text: """
As long as humans can think, there will be wars. Wars over such concepts as freedom, honor, dignity, etc.. Wars over territory, greed, power, prejudice, etc.. War is a part of human nature. For example, every human being is prejudiced. If they don’t like some race, nationality or religion, they don’t like short or tall or fat or skinny or smart or not smart or loud or quiet people. Some people don’t like children, some people don’t like old people, some people don’t like people with pets, or people that play their music too loud, or bad drivers, or people that believe in God or people that don’t believe in God.
As long as humans can think, there will be wars. Wars over such concepts as freedom, honor, dignity, etc.. Wars over territory, greed, power, prejudice, etc.. War is a part of human nature. For example, every human being is prejudiced. If they don’t like some race, nationality or religion, they don’t like short or tall or fat or skinny or smart or not smart or loud or quiet people. Some people don’t like children, some people don’t like old people, some people don’t like people with pets, or people that play their music too loud, or bad drivers, or people that believe in God or people that don’t believe in God.
""",
        textColor: .black,
        font: UIFont.systemFont(ofSize: 15, weight: .regular),
        numberOfLines: 0,
        textAlignment: .left
    )
    
    private lazy var capitalImage = createImageView(imageResource: .star)
    private lazy var populationImage = createImageView(imageResource: .face)
    private lazy var continentImage = createImageView(imageResource: .earth)
    
    private lazy var capitalStackView = createStackView(
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        spacing: 10,
        subviews: [capitalImage, capitalTitleLabel, capitalInfoLabel]
    )
    
    private lazy var populationStackView = createStackView(
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        spacing: 10,
        subviews: [populationImage, populationTitleLabel, populationInfoLabel]
    )
    
    private lazy var continentStackView = createStackView(
        axis: .horizontal,
        alignment: .fill,
        distribution: .fill,
        spacing: 10,
        subviews: [continentImage, continentTitleLabel, continentInfoLabel]
    )
    
    private lazy var countryInfoStackView = createStackView(
        axis: .vertical,
        alignment: .fill,
        distribution: .fill,
        spacing: 20,
        subviews: [capitalStackView, populationStackView, continentStackView]
    )
    
    private lazy var descriptionStackView = createStackView(
        axis: .vertical,
        alignment: .leading,
        distribution: .fill,
        spacing: 10,
        subviews: [aboutLabel, descriptionLabel]
    )
    
    private lazy var mainStackView = createStackView(
        axis: .vertical,
        alignment: .fill,
        distribution: .fill,
        spacing: 30,
        subviews: [countryInfoStackView, descriptionStackView]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Argentina"
        navigationController?.navigationBar.prefersLargeTitles = true
        addSubviews()
        applyConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
    }
    
    private func applyConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        [capitalImage, populationImage, continentImage].forEach { image in
            image.snp.makeConstraints {
                $0.width.height.equalTo(22)
            }
        }
    }
    private func createLabel(text: String? = nil, textColor: UIColor, font: UIFont, numberOfLines: Int, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        return label
    }
    
    private func createImageView(imageResource: ImageResource) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(resource: imageResource)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func createStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat, subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        subviews.forEach { view in
            stackView.addArrangedSubview(view)
        }
        return stackView
    }
}
