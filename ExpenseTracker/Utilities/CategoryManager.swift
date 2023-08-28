//
//  CategoryManager.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 28.08.2023.
//

import Foundation

class CategoryManager: ObservableObject {
    @Published var categories: [Category]
    
    init() {
        categories = Category.defaultCategories
    }
    
    func addCategory(_ category: Category) {
        DispatchQueue.main.async {
            self.categories.append(category)
        }
    }
}
