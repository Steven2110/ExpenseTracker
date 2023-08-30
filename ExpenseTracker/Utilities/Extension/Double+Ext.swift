//
//  Double+Ext.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import Foundation

extension Formatter {
    static let number = NumberFormatter()
}

extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
}

extension Double {
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        
        if let formattedValue = Formatter.number.string(for: self) {
            let currencyCode = locale.currencySymbol ?? ""
            let currencyIndex = formattedValue.getIndex(of: currencyCode)
            let currencyFormat = currencyIndex == 0 ? "\(currencyCode) " : "\(currencyCode)"
            let formattedString = formattedValue.replacingOccurrences(of: currencyCode, with: currencyFormat)
            return formattedString
        }
        return ""
    }
}
