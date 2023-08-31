//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import Foundation

struct Expense: Identifiable, Equatable {
    let id: UUID = UUID()
    var name: String
    var category: Category
    var date: Date
    var amount: Double
    
    static let emptyExpense: Expense = Expense(name: "", category: Category(categoryName: "", categoryIcon: ""), date: Date(), amount: 0.0)
    
    static var sampleData: [Expense] = [
        .init(name: "Fly to Paris", category: Category.travel, date: getDateFromStr("12.08.23"), amount: 1300.00),
        .init(name: "Internet", category: Category.internet, date: getDateFromStr("14.08.23"), amount: 70.0),
        .init(name: "Apple Developer Program", category: Category.development, date: getDateFromStr("14.08.23"), amount: 99.00),
        .init(name: "Apple Music Subscription", category: Category.entertainment, date: getDateFromStr("14.08.23"), amount: 35.0),
        .init(name: "Tuition Fee", category: Category.education, date: getDateFromStr("25.08.23"), amount: 1496),
        .init(name: "MacBook Air", category: Category.education, date: Date(), amount: 99999)
    ]
}
