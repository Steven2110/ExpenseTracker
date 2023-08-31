//
//  Currency.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 31.08.2023.
//

import Foundation

struct Currency: Identifiable, Hashable {
    let id: UUID = UUID()
    let currencyName: String
    let currencyLocaleStr: String
    
    static let currencies: [Currency] = [
        Currency(currencyName: "United States Dollar", currencyLocaleStr: "en_US"),
        Currency(currencyName: "Pound Sterling", currencyLocaleStr: "en_GB"),
        Currency(currencyName: "Euro", currencyLocaleStr: "eu_EU"),
        
        Currency(currencyName: "Russian Ruble", currencyLocaleStr: "ru_RU"),
        Currency(currencyName: "Czech Koruna", currencyLocaleStr: "cs_CZ"),
        Currency(currencyName: "Ukrainian Hryvnia", currencyLocaleStr: "uk_UA"),
        Currency(currencyName: "Polish Zloty", currencyLocaleStr: "pl_PL"),
        Currency(currencyName: "Kazakhstani Tenge", currencyLocaleStr: "kk_KZ"),
        Currency(currencyName: "Turkish Lira", currencyLocaleStr: "tr_TR"),
        
        Currency(currencyName: "Chinese Yuan", currencyLocaleStr: "cn_CN"),
        Currency(currencyName: "Japanese Yen", currencyLocaleStr: "tr_TR"),
        Currency(currencyName: "Singapore Dollar", currencyLocaleStr: "en_SG"),
        Currency(currencyName: "Malaysian Ringgit", currencyLocaleStr: "ms_MY"),
        Currency(currencyName: "Indonesian Rupiah", currencyLocaleStr: "id_ID"),
        Currency(currencyName: "Cambodian Riel", currencyLocaleStr: "km_KH"),
        Currency(currencyName: "South Korean Won", currencyLocaleStr: "ko_KR"),
        Currency(currencyName: "Vietnamese Dong", currencyLocaleStr: "vi_VN"),
        Currency(currencyName: "Thai Baht", currencyLocaleStr: "th_TH"),
        Currency(currencyName: "Philippine Peso", currencyLocaleStr: "fil_PH"),
        Currency(currencyName: "Laotian Kip", currencyLocaleStr: "lo_LA"),
        Currency(currencyName: "Myanmar Kyat", currencyLocaleStr: "my_MM"),
        
        Currency(currencyName: "Norwegian Krona", currencyLocaleStr: "nn_NO"),
        Currency(currencyName: "Swedish Krona", currencyLocaleStr: "sv_SE"),
        Currency(currencyName: "Icelandic Krona", currencyLocaleStr: "is_IS"),
    ]
}
