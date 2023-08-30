//
//  ChangeCurrency.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 30.08.2023.
//

import SwiftUI

struct ChangeCurrency: View {
    let currencies: [String] = [
        "en_RU",
        "en_US",
        "en_GB",
        "ru_RU",
        "id_ID",
        "cs_CZ"
    ]
    
    @ObservedObject var userSettings = UserSettingsManager.shared
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select currency", selection: $userSettings.currencyStr) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                            .tag(currency)
                    }
                }
            }
            .navigationTitle("Select Currency")
        }
    }
}

struct ChangeCurrency_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCurrency()
    }
}
