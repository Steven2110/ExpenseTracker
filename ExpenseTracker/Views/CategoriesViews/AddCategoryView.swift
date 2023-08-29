//
//  AddCategoryView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 28.08.2023.
//

import SwiftUI

struct AddCategoryView: View {
    @EnvironmentObject private var categoryManager: CategoryManager
    @Environment(\.dismiss) private var dismiss
    
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
                        guard checkValidity() else {
                            // -TODO: Show alert
                            print("Error")
                            return
                        }
                        let newCategory = Category(categoryName: categoryName, categoryIcon: categoryIcon)
                        categoryManager.addCategory(newCategory)
                        dismiss()
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

extension AddCategoryView {
    private func checkValidity() -> Bool {
        guard !categoryName.isEmpty else { return false }
        return true
    }
}
