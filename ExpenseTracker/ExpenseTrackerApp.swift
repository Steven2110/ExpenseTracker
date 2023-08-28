//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 23.08.2023.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let categoryManager: CategoryManager = CategoryManager()
    var body: some Scene {
        WindowGroup {
            ETTabView()
                .environmentObject(categoryManager)
        }
    }
}
