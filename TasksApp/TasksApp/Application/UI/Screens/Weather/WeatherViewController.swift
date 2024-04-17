//
//  WeatherViewController.swift
//  TasksApp
//
//  Created by user on 03.04.2024.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    private var weatherNetworkManager: WeatherNetworkManager!
    private var weatherInfo: WeatherInfo?
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    
    func addDependency(weatherNetworkManager: WeatherNetworkManager) {
        self.weatherNetworkManager = weatherNetworkManager
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        countryLabel.textAlignment = .center
        return countryLabel
    }()
    
    private let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        cityLabel.textAlignment = .center
        return cityLabel
    }()
    
    private let currentWeatherLabel: UILabel = {
        let currentWeatherLabel = UILabel()
        currentWeatherLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        currentWeatherLabel.textAlignment = .center
        return currentWeatherLabel
    }()
    
    private let averageDayTemp: UILabel = {
        let averageDayTemp = UILabel()
        averageDayTemp.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        averageDayTemp.textAlignment = .center
        averageDayTemp.numberOfLines = 0
        return averageDayTemp
    }()
    
    private let averageNightTemp: UILabel = {
        let averageNightTemp = UILabel()
        averageNightTemp.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        averageNightTemp.textAlignment = .center
        averageNightTemp.numberOfLines = 0
        return averageNightTemp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        title = "Погода"
        addSubviews()
        configureVStackView()
        configureHStackView()
        applyConstraints()
        makeRequest()
    }
    
    private func addSubviews() {
        view.addSubview(verticalStackView)
        view.addSubview(activityIndicator)
    }
    
    private func configureVStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 25
        verticalStackView.distribution = .equalCentering
        verticalStackView.addArrangedSubview(countryLabel)
        verticalStackView.addArrangedSubview(cityLabel)
        verticalStackView.addArrangedSubview(currentWeatherLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
    }
    
    private func configureHStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .center
        horizontalStackView.addArrangedSubview(averageDayTemp)
        horizontalStackView.addArrangedSubview(averageNightTemp)
    }

    private func applyConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func displayWeather(from weatherData: WeatherData) {
        weatherInfo = WeatherInfo(weatherData: weatherData)
        countryLabel.text = weatherInfo?.countryName
        cityLabel.text = weatherInfo?.cityName
        currentWeatherLabel.text = weatherInfo?.currentTempDescription
        averageDayTemp.text = weatherInfo?.averageDayTempDescription
        averageNightTemp.text = weatherInfo?.averageNightTempDescription
    }
    
    private func makeRequest() {
        activityIndicator.startAnimating()
        weatherNetworkManager.makeRequest(type: WeatherData.self) { [weak self] result in
            switch result {
            case .success(let weatherData):
                if let weatherData = weatherData {
                    self?.displayWeather(from: weatherData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.activityIndicator.stopAnimating()
        }
    }
}
