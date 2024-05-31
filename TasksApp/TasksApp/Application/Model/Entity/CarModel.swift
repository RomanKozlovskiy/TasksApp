//
//  CarModel.swift
//  TasksApp
//
//  Created by user on 29.05.2024.
//

import UIKit

protocol CarInfoProtocol {
    var carName: String { get set }
    var carLogo: UIImage { get set }
    var carDescription: String { get set }
}

struct Bmw: CarInfoProtocol {
    var carName: String = "BMW M3"
    var carLogo: UIImage = UIImage(resource: .BMW_M_3)
    var carDescription: String = """
BMW M3 - Cпортивные версии автомобилей BMW 3 серии от дочерней компании BMW M GmbH. Основными отличиями от «стандартных» автомобилей BMW 3 серии являются более мощный двигатель, улучшенная подвеска, изменённый дизайн, множественные акценты как в интерьере так и в экстерьере, указывающие на принадлежность к линейке «M»/Motorsport. Выпускаются с 1986 года.
"""
}

struct Audi: CarInfoProtocol {
    var carName: String = "Audi R8"
    var carLogo: UIImage = UIImage(resource: .audiR8)
    var carDescription: String = """
Audi R8 - В базовой комплектации Audi R8 оснащается атмосферным двигателем V8 объёмом 4,2 литра, использующим технологию FSI, который вырабатывает максимальную мощность равную 420 лошадиным силам. Разгон от 0 до 100 км/ч составляет 4,6 секунды. Максимальная скорость в целях безопасности ограничена электроникой на отметке 301 км/ч.
"""
}

struct Mercedes: CarInfoProtocol {
    var carName: String = "Mercedes-Benz S class"
    var carLogo: UIImage = UIImage(resource: .mercedesS)
    var carDescription: String = """
Mercedes-Benz S-класс — флагманская серия представительских автомобилей немецкой компании Mercedes-Benz, дочернего подразделения концерна Daimler AG. Представляет собой наиболее значимую линейку моделей в иерархии классов торговой марки. Первые представительские седаны появились ещё в начале 1950-х годов, но официально S-класс появился лишь в 1972 году. В настоящее время серия состоит из 7 поколений: W116, представленного в 1972 году и выпускавшегося до 1980 года; W126, дебютировавшего в 1979 году; W140, выпускавшегося с 1991 до 1999 года; W220, поступившего в продажу в 1998 году и завершивший производство в 2005; W221, представленного в 2005 году и собиравшегося до 2013 года включительно; W222, дебютировавшего в 2013 году и выпускавшегося до 2020; W223, премьера которого состоялась в 2020 году.
"""
}
