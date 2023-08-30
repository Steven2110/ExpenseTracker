//
//  UserSettingsManager.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 30.08.2023.
//

import SwiftUI

class UserSettingsManager: ObservableObject {
    @AppStorage("currency") var currencyStr: String = Locale.current.identifier
    
    static let shared: UserSettingsManager = UserSettingsManager()
    
    private init() { }
}
