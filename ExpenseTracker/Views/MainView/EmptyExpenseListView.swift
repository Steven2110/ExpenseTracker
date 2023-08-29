//
//  EmptyExpenseListView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 29.08.2023.
//

import SwiftUI

struct EmptyExpenseListView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("You haven't spend anything this month. 🤑")
                .font(.title2)
            Text("Did you just spent on something? 💸")
                .font(.title3)
            Button {
                // -TODO: Show sheet to add new expense
            } label: {
                Text("Add Expense")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 140, height: 70)
                    .background(Color.primaryAccent)
                    .cornerRadius(20)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct EmptyExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyExpenseListView()
    }
}
