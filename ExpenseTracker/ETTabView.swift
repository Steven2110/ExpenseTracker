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
                Text("Add Expense View")
                .tabItem {
                    Label("Add Expense", systemImage: "plus.circle")
                }
            }
            .toolbar(.visible, for: .tabBar)
        }
    }
}

struct ETTabView_Previews: PreviewProvider {
    static var previews: some View {
        ETTabView()
    }
}
