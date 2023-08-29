//
//  ExpenseDetailEditView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 27.08.2023.
//

import SwiftUI

struct ExpenseDetailEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var expense: Expense
    @State private var expenseAmountStr: String = ""
    var body: some View {
        Form {
            LabeledContent {
                ClearableTextField("Expense Name", text: $expense.name).multilineTextAlignment(.trailing)
            } label: {
                Text("Expense name")
            }
            CategoryPicker(category: $expense.category)
            LabeledContent {
                ClearableTextField("0.0", text: $expenseAmountStr)
                    .fixedSize()
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            } label: {
                Text("Expense amount ($)")
            }
            VStack {
                Text("Transaction date").frame(maxWidth: .infinity, alignment: .leading)
                DatePicker("Transaction date", selection: $expense.date).datePickerStyle(.graphical)
            }
            Section {
                Button("Done") {
                    guard checkValidity() else {
                        // -TODO: Show alert
                        print("Missing one or all of the value in text field.")
                        return
                    }
                    
                    let formatter = NumberFormatter()
                    formatter.decimalSeparator = ","
                    
                    guard let formattedValue = formatter.number(from: expenseAmountStr) else {
                        // -TODO: Show alert
                        print("Error value of expense amount")
                        return
                    }
                    let amount = Double(truncating: formattedValue)
                    expense.amount = amount
                    dismiss()
                }
            }
        }
        .onAppear {
            expenseAmountStr = String(format: "%.2f", expense.amount).replacingOccurrences(of: ".", with: ",")
        }
        .navigationTitle("Edit Expense")
    }
}

struct ExpenseDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetailEditView(expense: .constant(Expense.sampleData[0]))
    }
}

extension ExpenseDetailEditView {
    private func checkValidity() -> Bool {
        guard !expense.name.isEmpty,
              !expenseAmountStr.isEmpty
        else { return false }
        
        return true
    }
}
