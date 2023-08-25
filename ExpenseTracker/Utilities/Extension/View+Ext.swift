//
//  View+Ext.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 25.08.2023.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
