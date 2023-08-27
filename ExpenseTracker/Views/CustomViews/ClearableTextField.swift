//
//  ClearableTextField.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 27.08.2023.
//

import SwiftUI

struct ClearableTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
    }
}

struct ClearableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ClearableTextField("Expense Name", text: .constant("Tuition Fee"))
    }
}
