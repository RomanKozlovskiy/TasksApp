//
//  Extensions + Int.swift
//  TasksApp
//
//  Created by user on 26.04.2024.
//

import Foundation

extension Int {
    func formatDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        numberFormatter.groupingSize = 3
        numberFormatter.groupingSeparator = " "
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedNumber
        }
        return ""
    }
}
