//
//  ExpenseDetailView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 27.08.2023.
//

import SwiftUI

struct ExpenseDetailView: View {
    @ObservedObject private var userSettings: UserSettingsManager = UserSettingsManager.shared
    
    @Binding var expense: Expense
    var body: some View {
        ZStack {
            Rectangle().fill(Color.brandPrimary.gradient)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: expense.category.categoryIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .rotationEffect(expense.category.categoryIcon == "airplane" ? Angle(degrees: -45) : Angle(degrees: 0))
                    .padding()
                    .foregroundColor(Color.primaryAccent)
                    .background(Color.gray.opacity(0.7))
                    .clipShape(Circle())
                Text(expense.name)
                    .font(.largeTitle)
                Text("\(expense.amount.formatted(style: .currency, locale: Locale(identifier: userSettings.currencyStr)))").font(.largeTitle)
                Text(expense.category.categoryName).foregroundColor(.secondary)
                Text(getDateStr(expense.date))
            }
        }
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetailView(expense: .constant(Expense.sampleData[0]))
    }
}
