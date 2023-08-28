//
//  AddCategoryView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 28.08.2023.
//

import SwiftUI

struct AddCategoryView: View {
    @State private var categoryName: String = ""
    @State private var categoryIcon: String = "house.fill"
    @State private var showIconPicker: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("Category Name", text: $categoryName).multilineTextAlignment(.trailing)
                } label: {
                    Text("Category Name")
                }
                Button {
                    showIconPicker = true
                } label: {
                    HStack {
                        Text("Icon").foregroundColor(.black)
                        Spacer()
                        Image(systemName: categoryIcon)
                    }
                }
                Section {
                    Button("Save") {
                        
                    }
                }
            }
            .navigationTitle("Add Category")
            .sheet(isPresented: $showIconPicker) {
                CategoryIconPicker(selectedIcon: $categoryIcon)
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
