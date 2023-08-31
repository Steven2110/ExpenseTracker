//
//  ETTabView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import SwiftUI

struct ETTabView: View {
    @State private var expenses: [Expense] = Expense.sampleData
    
    @State private var selectedItem = 1
    @State private var previousSelectedItem = 1
    @State private var isPresentingAddSheet = false
    
    var body: some View {
        TabView(selection: $selectedItem) {
            Group {
                MainView(expenses: $expenses)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(1)
                CategoriesView()
                    .tabItem {
                        Label("Categories", systemImage: "list.clipboard.fill")
                    }
                    .tag(2)
                Text("Add Expense Sheet")
                    .tabItem {
                        Label("Add Expense", systemImage: "plus.circle")
                    }
                    .tag(3)
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .toolbar(.visible, for: .tabBar)
        }
        .tint(.primaryAccent)
        .onChange(of: selectedItem) { newValue in
            if newValue == 3 {
                isPresentingAddSheet = true
                selectedItem = previousSelectedItem
            } else {
                previousSelectedItem = newValue
            }
        }
        .sheet(isPresented: $isPresentingAddSheet) {
            AddExpenseForm(expenses: $expenses)
        }
    }
}

struct ETTabView_Previews: PreviewProvider {
    static var previews: some View {
        ETTabView()
    }
}
