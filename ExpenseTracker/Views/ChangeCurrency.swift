//
//  ChangeCurrency.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 30.08.2023.
//

import SwiftUI

struct ChangeCurrency: View {
    // TODO: Need to create Currency model and store all these currencies below 
    let currencies: [String] = [
        "en_US",
        "en_GB",
        "eu_EU",
        
        "ru_RU",
        "en_CZ",
        "uk_UA",
        "pl_PL",
        "kk_KZ",
        "tr_TR",
        "cs_CZ",
        
        "cn_CN",
        "ja_JP",
        "en_SG",
        "ms_MY",
        "id_ID",
        "km_KH",
        "ko_KR",
        "vi_VN",
        "th_TH",
        "fil_PH",
        "lo_LA",
        "my_MM",
        
        "nn_NO",
        "sv_SE",
        "is_IS",
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
