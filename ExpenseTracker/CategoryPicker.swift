//
//  CategoryPicker.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 26.08.2023.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var category: Category
    
    var body: some View {
        Picker("Category", selection: $category) {
            ForEach(Category.defaultCategories) { category in
                CategoryView(category: category)
                    .tag(category)
            }
        }.pickerStyle(.navigationLink)
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPicker(category: .constant(Category.development))
    }
}
