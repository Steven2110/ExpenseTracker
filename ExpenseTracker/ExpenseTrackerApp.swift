//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 23.08.2023.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @ObservedObject private var userSettings: UserSettingsManager = UserSettingsManager.shared
    let categoryManager: CategoryManager = CategoryManager()
    var body: some Scene {
        WindowGroup {
            ETTabView()
                .environmentObject(categoryManager)
                .environment(\.colorScheme, userSettings.isDarkMode ? .dark : .light)
        }
    }
}
