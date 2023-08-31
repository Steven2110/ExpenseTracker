//
//  AddExpenseForm.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 24.08.2023.
//

import SwiftUI

struct AddExpenseForm: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var userSettings: UserSettingsManager = UserSettingsManager.shared
    
    @Binding var expenses: [Expense]
    
    @State private var name: String = ""
    @State private var category: Category = Category.food
    @State private var amountStr: String = ""
    @State private var transactionDate: Date = Date()

    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("Expense name", text: $name).multilineTextAlignment(.trailing)
                } label: {
                    Text("Expense name")
                }
                CategoryPicker(category: $category)
                LabeledContent {
                    TextField("0.00", text: $amountStr)
                        .fixedSize()
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                } label: {
                    Text("Expense amount (\(Locale(identifier: userSettings.currencyStr).currencySymbol ?? ""))")
                }
                VStack {
                    Text("Transaction date").frame(maxWidth: .infinity, alignment: .leading)
                    DatePicker("Transaction date", selection: $transactionDate).datePickerStyle(.graphical)
                }
                Section {
                    Button("Add") {
                        guard checkValidity() else {
                            // -TODO: Show alert
                            print("Missing one or all of the value in text field.")
                            return
                        }
                        
                        let formatter = NumberFormatter()
                        formatter.decimalSeparator = ","
                        
                        guard let formattedValue = formatter.number(from: amountStr) else {
                            // -TODO: Show alert
                            print("Error value of expense amount")
                            return
                        }
                        let amount = Double(truncating: formattedValue)
                        
                        let expense = Expense(name: name, category: category, date: transactionDate, amount: amount)
                        
                        expenses.append(expense)
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button(action: dismissKeyboard) {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
    }
}

struct AddExpenseForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddExpenseForm(expenses: .constant(Expense.sampleData))
        }
    }
}

extension AddExpenseForm {
    private func checkValidity() -> Bool {
        guard !name.isEmpty,
              !amountStr.isEmpty
        else { return false }
        
        return true
    }
}
