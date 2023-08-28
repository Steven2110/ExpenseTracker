//
//  ETTabView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import SwiftUI

struct ETTabView: View {
    @State private var expenses: [Expense] = Expense.sampleData
    var body: some View {
        TabView {
            Group {
                MainView(expenses: $expenses)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                CategoriesView()
                    .tabItem {
                        Label("Categories", systemImage: "list.clipboard.fill")
                    }
                NavigationStack {
                    AddExpenseForm(expenses: $expenses)
                        .navigationTitle("Add New Expense")
                }
                .tabItem {
                    Label("Add Expense", systemImage: "plus.circle")
                }
            }
            .toolbar(.visible, for: .tabBar)
        }.tint(.primaryAccent)
    }
}

struct ETTabView_Previews: PreviewProvider {
    static var previews: some View {
        ETTabView()
    }
}
