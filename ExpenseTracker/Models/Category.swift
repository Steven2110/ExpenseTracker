//
//  Category.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: UUID = UUID()
    var categoryName: String
    var categoryIcon: String
    
    static let all: Category = Category(categoryName: "All", categoryIcon: "")
    static let food: Category = Category(categoryName: "Food", categoryIcon: "fork.knife")
    static let transportation: Category = Category(categoryName: "Transportation", categoryIcon: "car")
    static let travel: Category = Category(categoryName: "Travel", categoryIcon: "airplane")
    static let internet: Category = Category(categoryName: "Internet", categoryIcon: "wifi")
    static let development: Category = Category(categoryName: "Development", categoryIcon: "text.word.spacing")
    static let entertainment: Category = Category(categoryName: "Entertainment", categoryIcon: "music.note")
    static let education: Category = Category(categoryName: "Education", categoryIcon: "graduationcap.fill")
    
    static let defaultCategories: [Category] = [
        Category.food,
        Category.transportation,
        Category.travel,
        Category.internet,
        Category.entertainment,
        Category.development,
        Category.education
    ]
    static let categoriesFilter: [Category] = [
        Category.all,
        Category.food,
        Category.transportation,
        Category.travel,
        Category.internet,
        Category.entertainment,
        Category.development,
        Category.education
    ]
}
