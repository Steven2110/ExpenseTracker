//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 30.08.2023.
//

import SwiftUI

struct SettingsView: View {
    let currencies: [Currency] = Currency.currencies
    
    @ObservedObject var userSettings = UserSettingsManager.shared
    var body: some View {
        NavigationStack {
            List {
                Picker("Currency", selection: $userSettings.currency) {
                    ForEach(currencies) { currency in
                        Text("\(currency.currencyName) – \(Locale(identifier: currency.currencyLocaleStr).currencySymbol ?? "")")
                            .tag(currency)
                    }
                }.pickerStyle(.navigationLink)
                Toggle("Dark Mode", isOn: $userSettings.isDarkMode.animation(.easeInOut))
            }
            .navigationTitle("Setting")
        }
    }
}

struct ChangeCurrency_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
