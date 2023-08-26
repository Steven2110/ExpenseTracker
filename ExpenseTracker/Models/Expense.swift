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
    var category: Category
    var date: Date
    var amount: Double
    
    static var sampleData: [Expense] = [
        .init(name: "Fly to Paris", category: Category.travel, date: Date(), amount: 1300.00),
        .init(name: "Internet", category: Category.internet, date: Date(), amount: 70.0),
        .init(name: "Apple Developer Program", category: Category.development, date: Date(), amount: 99.00),
        .init(name: "Apple Music Subscription", category: Category.entertainment, date: Date(), amount: 35.0),
        .init(name: "Tuition Fee", category: Category.education, date: Date(), amount: 1496),
        .init(name: "MacBook Air", category: Category.education, date: Date(), amount: 99999)
    ]
}
