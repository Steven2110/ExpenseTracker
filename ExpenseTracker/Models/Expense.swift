//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import Foundation

struct Expense: Identifiable {
    let id: UUID = UUID()
    var name: String
    var icon: String
    var date: Date
    var amount: Double
    
    static var sampleData: [Expense] = [
        .init(name: "Fly to Paris", icon: "airplane", date: Date(), amount: 1300.00),
        .init(name: "Internet", icon: "wifi", date: Date(), amount: 70.0),
        .init(name: "Apple Developer Program", icon: "apple.logo", date: Date(), amount: 99.00),
        .init(name: "Apple Music Subscription", icon: "music.note", date: Date(), amount: 35.0),
        .init(name: "Tuition Fee", icon: "graduationcap.fill", date: Date(), amount: 1496)
    ]
}
