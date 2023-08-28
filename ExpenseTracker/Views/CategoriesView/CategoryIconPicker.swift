//
//  CategoryIconPicker.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 28.08.2023.
//

import SwiftUI

struct CategoryIconPicker: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIcon: String
    
    let columns = [GridItem(.adaptive(minimum: 100, maximum: 150))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(CategoryIcons, id: \.self) { icon in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(selectedIcon == icon ? Color.brandPrimary : Color.secondaryAccent)
                            .opacity(0.6)
                            .frame(width: 50, height: 50)
                            .overlay{
                                Image(systemName: icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                                    .foregroundColor(.primaryAccent)
                            }
                            .onTapGesture {
                                selectedIcon = icon
                                dismiss()
                            }
                    }
                }
            }
            .padding()
            .navigationTitle("Select Icon")
        }
    }
}

struct CategoryIconPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIconPicker(selectedIcon: .constant("car"))
    }
}
