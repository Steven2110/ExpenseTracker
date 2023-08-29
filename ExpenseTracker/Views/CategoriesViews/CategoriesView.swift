//
//  CategoriesView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 27.08.2023.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject private var categoryManager: CategoryManager
    
    @State private var showAddCategory: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(categoryManager.categories) { category in
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
                    .listRowBackground(Color.brandPrimary)
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddCategory = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView()
                    .presentationDetents([.fraction(0.6)])
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(CategoryManager())
    }
}
