//
//  CategoryView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 26.08.2023.
//

import SwiftUI

struct CategoryView: View {
    var category: Category
    
    var body: some View {
        HStack {
            Image(systemName: category.categoryIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .rotationEffect(category.categoryIcon == "airplane" ? Angle(degrees: -45) : Angle(degrees: 0))
                .padding()
                .foregroundColor(Color.primaryAccent)
                .background(Color.gray.opacity(0.4))
                .clipShape(Circle())
            Text(category.categoryName)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category.development)
    }
}
