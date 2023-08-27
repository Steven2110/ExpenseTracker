//
//  MainView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 23.08.2023.
//

import SwiftUI

struct MainView: View {
    @Binding var expenses: [Expense]
    @State private var filter: Category = Category.all
    @State private var sortAmount: SortType = .none
    @State private var sortDate: SortType = .descending
    var sortAmountText: String {
        switch sortAmount {
        case .ascending:
            return "Amount ▲"
        case .descending:
            return "Amount ▼"
        case .none:
            return "Amount ━"
        }
    }
    var sortDateText: String {
        switch sortDate {
        case .ascending:
            return "Date ▲"
        case .descending:
            return "Date ▼"
        case .none:
            return "Date ━"
        }
    }
    @State private var sortedExpenses: [Expense] = []
    @State private var offsetY: CGFloat = 0
    
    @State private var isShowingDetailView: Bool = false
    @State private var isShowingEditView: Bool = false
    @State private var selectedExpense: Expense = Expense.sampleData[0]
    @State private var editingExpense: Expense = Expense.emptyExpense
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets
            ScrollView(showsIndicators: false) {
                VStack {
                    HeaderView(size: size, safeArea: safeArea)
                        .zIndex(1)
                    ForEach(sortedExpenses) { expense in
                        ExpenseRowView(expense: expense)
                            .onTapGesture {
                                selectedExpense = expense
                                isShowingDetailView = true
                            }
                    }.padding(.horizontal)
                }
                .background {
                    ScrollDetector { offset in
                        offsetY = -offset
                    } onDraggingEnd: { _, _ in }

                }
            }.ignoresSafeArea(edges: .top)
        }
        .onAppear {
            sortedExpenses = sortedFilteredExpenses()
        }
        .sheet(isPresented: $isShowingDetailView) {
            NavigationStack {
                ExpenseDetailView(expense: $selectedExpense)
                    .toolbar {
                        ToolbarItem {
                            Button("Edit") {
                                isShowingEditView = true
                                editingExpense = selectedExpense
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                expenses.removeAll(where: { $0.id == selectedExpense.id })
                                isShowingDetailView = false
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingEditView) {
                        NavigationStack {
                            ExpenseDetailEditView(expense: $editingExpense)
                                .onDisappear {
                                    selectedExpense = editingExpense
                                }
                        }
                    }
                    .onDisappear {
                        guard let index = expenses.firstIndex(where: { $0.id == selectedExpense.id }) else {
                            sortedExpenses = getSortedExpenses()
                            return
                        }
                        expenses[index] = selectedExpense
                        sortedExpenses = getSortedExpenses()
                    }
            }
            .presentationDetents([.fraction(0.5)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(expenses: .constant(Expense.sampleData))
    }
}

extension MainView {
    @ViewBuilder
    func HeaderView(size: CGSize, safeArea: EdgeInsets) -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top + 50
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        var totalAmountWidth: CGFloat {
            let max = 230.0
            if size.width - 175 * progress < max {
                return max
            }
            return size.width - 175 * progress
        }
        
        GeometryReader { geo in
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.brandPrimary.gradient)
                    
                    VStack {
                        if offsetY >= 0.0{
                            Text("Your expense")
                                .font(.title3)
                        }
                        GeometryReader { geo in
                            let rect = geo.frame(in: .global)
                            HStack {
                                Text("\(expenses.map({ $0.amount }).reduce(0, +).currency)")
                                    .minimumScaleFactor(0.92)
                                    .font(.largeTitle)
                                    .bold()
                                Image(systemName: "triangle.fill")
                                    .rotationEffect(Angle(degrees: 180))
                                    .foregroundColor(.orchid)
                            }
                            .scaleEffect(1 - (progress * 0.15))
                            .frame(height: rect.height)
                            .frame(maxWidth: .infinity)
                            .offset(x: -rect.minX * progress)
                        }
                        .frame(width: totalAmountWidth, height: headerHeight * 0.25 * (1 - progress))
                        Text("August 2023").offset(x: size.width * 0.33 * progress,y: -20 * progress)
                    }
                    .padding(.top, offsetY >= 0.0 ? safeArea.top : safeArea.top + 10)
                    .padding(.bottom, 15)
                }
                .frame(height: (headerHeight - 75 + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight - 75 + offsetY))
                .offset(y: -offsetY)
                ZStack {
                    Rectangle().fill(Color.brandBackground)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Text(sortAmountText)
                                .frame(height: 50)
                                .padding(.horizontal)
                                .overlay {
                                    Capsule(style: .continuous)
                                        .stroke(Color.primaryAccent, lineWidth: 2)
                                }
                                .padding(3)
                                .onTapGesture {
                                    if sortAmount == .ascending {
                                        sortAmount = .descending
                                    } else if sortAmount == .descending {
                                        sortAmount = .none
                                    } else if sortAmount == .none {
                                        sortAmount = .ascending
                                    }
                                    sortedExpenses = sortedFilteredExpenses()
                                }
                            Text(sortDateText)
                                .frame(height: 50)
                                .padding(.horizontal)
                                .overlay {
                                    Capsule(style: .continuous)
                                        .stroke(Color.primaryAccent, lineWidth: 2)
                                }
                                .padding(3)
                                .onTapGesture {
                                    if sortDate == .ascending {
                                        sortDate = .descending
                                    } else if sortDate == .descending {
                                        sortDate = .none
                                    } else if sortDate == .none {
                                        sortDate = .ascending
                                    }
                                    sortedExpenses = sortedFilteredExpenses()
                                }
                            Picker("", selection: $filter) {
                                ForEach(Category.categoriesFilter) { category in
                                    Text(category.categoryName).tag(category)
                                }
                            }
                            .tint(.black)
                            .pickerStyle(.menu)
                            .frame(height: 50)
                            .padding(.horizontal)
                            .overlay {
                                Capsule(style: .continuous)
                                    .stroke(Color.primaryAccent, lineWidth: 2)
                            }
                            .padding(3)
                            .onChange(of: filter) { _ in
                                sortedExpenses = sortedFilteredExpenses()
                            }
                        }.padding(.horizontal)
                    }
                }
                .frame(height: 75)
                .offset(y: -offsetY)
            }
        }.frame(height: headerHeight)
    }
    
    enum SortType {
        case ascending, descending, none
    }
    
    func sortedFilteredExpenses() -> [Expense] {
        let sortedExpenses = getSortedExpenses()
        
        if filter.categoryName == "All" {
            return sortedExpenses
        } else {
            return sortedExpenses.filter({ $0.category.categoryName == filter.categoryName })
        }
    }
    
    func getSortedExpenses() -> [Expense] {
        if sortDate == .ascending && sortAmount == .ascending {
            // -MARK: Date ascending, Amount ascending
            return expenses.sorted { expense1, expense2 in
                if expense1.date == expense2.date {
                    return expense1.amount < expense2.amount
                }
                return expense1.date < expense2.date
            }
        } else if sortDate == .ascending && sortAmount == .descending {
            // -MARK: Date ascending, Amount descending
            return expenses.sorted { expense1, expense2 in
                if expense1.date == expense2.date {
                    return expense1.amount > expense2.amount
                }
                return expense1.date < expense2.date
            }
        } else if sortDate == .ascending && sortAmount == .none {
            // -MARK: Date ascending, Amount none
            return expenses.sorted { expense1, expense2 in
                return expense1.date < expense2.date
            }
        } else if sortDate == .descending && sortAmount == .ascending {
            // -MARK: Date descending, Amount ascending
            return expenses.sorted { expense1, expense2 in
                if expense1.date == expense2.date {
                    return expense1.amount < expense2.amount
                }
                return expense1.date > expense2.date
            }
        } else if sortDate == .descending && sortAmount == .descending {
            // -MARK: Date descending, Amount descending
            return expenses.sorted { expense1, expense2 in
                if expense1.date == expense2.date {
                    return expense1.amount > expense2.amount
                }
                return expense1.date > expense2.date
            }
        } else if sortDate == .descending && sortAmount == .none {
            // -MARK: Date descending, Amount none
            return expenses.sorted { expense1, expense2 in
                return expense1.date > expense2.date
            }
        } else if sortDate == .none && sortAmount == .ascending {
            // -MARK: Date none, Amount ascending
            return expenses.sorted { expense1, expense2 in
                return expense1.amount < expense2.amount
            }
        } else if sortDate == .none && sortAmount == .descending {
            // -MARK: Date none, Amount descending
            return expenses.sorted { expense1, expense2 in
                return expense1.amount > expense2.amount
            }
        } else {
            // -MARK: Date none, Amount none
            return expenses
        }
    }
}
