//
//  UserSettingsManager.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 30.08.2023.
//

import SwiftUI

class UserSettingsManager: ObservableObject {
    @AppStorage("currency") var currencyStr = "en_US"
    @AppStorage("isDarkMode") var isDarkMode = false
    var currency: Currency {
        get {
            Currency.currencies.first(where: { $0.currencyLocaleStr == currencyStr }) ?? Currency.currencies[0]
        }
        
        set {
            currencyStr = newValue.currencyLocaleStr
        }
    }
    
    static let shared: UserSettingsManager = UserSettingsManager()
    
    private init() { }
}
