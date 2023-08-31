//
//  ExpenseRowView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 26.08.2023.
//

import SwiftUI

struct ExpenseRowView: View {
    @ObservedObject var userSettings = UserSettingsManager.shared
    var expense: Expense
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.brandPrimary)
                .frame(height: 100)
            HStack {
                Image(systemName: expense.category.categoryIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .rotationEffect(expense.category.categoryIcon == "airplane" ? Angle(degrees: -45) : Angle(degrees: 0))
                    .padding()
                    .foregroundColor(Color.primaryAccent)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text(expense.name)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Text(getDateFormatted(from: expense.date)).font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(expense.amount.currencyFormatted())")
            }.padding(.horizontal, 10)
        }
    }
}

struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView(expense: Expense.sampleData[0])
    }
}
