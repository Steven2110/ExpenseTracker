//
//  ChangeCurrency.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 30.08.2023.
//

import SwiftUI

struct ChangeCurrency: View {
    let currencies: [Currency] = Currency.currencies
    
    @ObservedObject var userSettings = UserSettingsManager.shared
    var body: some View {
        NavigationStack {
            Picker("Select Currency", selection: $userSettings.currency) {
                ForEach(currencies) { currency in
                    Text("\(currency.currencyName) – \(Locale(identifier: currency.currencyLocaleStr).currencySymbol ?? "")")
                        .tag(currency)
                }
            }.pickerStyle(.navigationLink)
            .padding()
            .navigationTitle("Select Currency")
        }
    }
}

struct ChangeCurrency_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCurrency()
    }
}
