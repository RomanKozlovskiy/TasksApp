//
//  CarModel.swift
//  TasksApp
//
//  Created by user on 29.05.2024.
//

import UIKit

protocol CarInfoProtocol {
    var carLogo: UIImage { get set }
    var carDescription: String { get set }
}

struct Bmw: CarInfoProtocol {
    var carLogo: UIImage = UIImage(resource: .BMW_M_3)
    var carDescription: String = """
BMW M3 - Cпортивные версии автомобилей BMW 3 серии от дочерней компании BMW M GmbH. Основными отличиями от «стандартных» автомобилей BMW 3 серии являются более мощный двигатель, улучшенная подвеска, изменённый дизайн, множественные акценты как в интерьере так и в экстерьере, указывающие на принадлежность к линейке «M»/Motorsport. Выпускаются с 1986 года.
"""
}

struct Audi: CarInfoProtocol {
    var carLogo: UIImage = UIImage(resource: .audiR8)
    var carDescription: String = """
Audi R8 - В базовой комплектации Audi R8 оснащается атмосферным двигателем V8 объёмом 4,2 литра, использующим технологию FSI, который вырабатывает максимальную мощность равную 420 лошадиным силам. Разгон от 0 до 100 км/ч составляет 4,6 секунды. Максимальная скорость в целях безопасности ограничена электроникой на отметке 301 км/ч[
"""
}

