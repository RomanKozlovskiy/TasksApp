//
//  CountriesProvider.swift
//  TasksApp
//
//  Created by user on 23.04.2024.
//

import UIKit
import Foundation

final class CountriesProvider {
    private let countriesApiClient: CountriesApiClient
    private let coreDataService: CoreDataServiceProtocol
    private let cachingService: CachingService
    
    private var countriesAlreadyLoaded: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isLoaded.rawValue)
        } set {
            let defaults = UserDefaults.standard
            if let boolValue = newValue {
                defaults.set(boolValue, forKey: Keys.isLoaded.rawValue)
            } else {
                defaults.removeObject(forKey: Keys.isLoaded.rawValue)
            }
        }
    }
    
    init(countriesApiClient: CountriesApiClient, coreDataService: CoreDataServiceProtocol, cachingService: CachingService) {
        self.countriesApiClient = countriesApiClient
        self.coreDataService = coreDataService
        self.cachingService = cachingService
    }
    
    func fetchCountries(nextPage: String? = nil, completion: @escaping (CountryList?) -> Void) {
        countriesApiClient.makeRequest(nextPage: nextPage, type: CountryList.self) { [weak self] result in
            switch result {
            case .success(let countryList):
                DispatchQueue.main.async {
                    completion(countryList)
                    if let countries = countryList?.countries, self?.countriesAlreadyLoaded == false {
                        self?.saveCountries(with: countries)
                        self?.countriesAlreadyLoaded = true
                    }
                }
            case .failure(let error):
                print(error)
                guard let countries = self?.getCountries() else { return }
                let countryList = CountryList(next: "", countries: countries)
                completion(countryList)
            }
        }
    }
    
    func getCountries() -> [Country] {
        do {
            let countriesManagedObject = try coreDataService.fetchCountries()
            let countries: [Country] = countriesManagedObject.compactMap { countryManagedObject in
                guard
                    let name = countryManagedObject.name,
                    let continent = countryManagedObject.continent,
                    let capital = countryManagedObject.capital,
                    let descriptionSmall = countryManagedObject.descriptionSmall,
                    let description = countryManagedObject.descriptionLarge
                else {
                    return Country(name: "", continent: "", capital: "", population: 0, descriptionSmall: "", description: "", image: "", countryInfo: CountryInfo(images: [], flag: ""))
                }
                return Country(name: name, continent: continent, capital: capital, population: Int(countryManagedObject.population), descriptionSmall: descriptionSmall, description: description, image: countryManagedObject.image ?? "", countryInfo: CountryInfo(images: [], flag: countryManagedObject.flag ?? ""))
            }
            return countries
        } catch {
            print(error)
            return []
        }
    }
    
    func saveCountries(with countries: [Country]) {
        coreDataService.save { context in
            countries.forEach { country in
                let countryManagedObject = CountryManagedObject(context: context)
                countryManagedObject.name = country.name
                countryManagedObject.continent = country.continent
                countryManagedObject.capital = country.capital
                countryManagedObject.population = Int32(country.population)
                countryManagedObject.descriptionSmall = country.descriptionSmall
                countryManagedObject.descriptionLarge = country.description
                countryManagedObject.image = country.image
                countryManagedObject.flag = country.countryInfo.flag
            }
        }
    }
    
    func getCachedObject(for key: AnyObject) -> UIImage? {
        cachingService.objectFor(key: key) as? UIImage
    }
    
    func setCachedObject(image: UIImage, key: AnyObject) {
        cachingService.setObject(object: image, key: key)
    }
    
    private enum Keys: String {
        case isLoaded
    }
}
