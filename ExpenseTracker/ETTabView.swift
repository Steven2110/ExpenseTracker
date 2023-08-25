//
//  ETTabView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import SwiftUI

struct ETTabView: View {
    var body: some View {
        TabView {
            Group {
                MainView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                NavigationStack {
                    AddExpenseForm()
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
