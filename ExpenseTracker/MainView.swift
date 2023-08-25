//
//  MainView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 23.08.2023.
//

import SwiftUI

struct MainView: View {
    var expenses: [Expense]
    
    @State private var offsetY: CGFloat = 0
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets
            ScrollView(showsIndicators: false) {
                VStack {
                    HeaderView(size: size, safeArea: safeArea)
                        .zIndex(1)
                    ForEach(expenses) { expense in
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
                                Text("\(expense.amount.currency)")
                            }.padding(.horizontal, 10)
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
    }
    
    func getDateFormatted(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM 'at' HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(expenses: Expense.sampleData)
    }
}

extension MainView {
    @ViewBuilder
    func HeaderView(size: CGSize, safeArea: EdgeInsets) -> some View {
        let headerHeight = (size.height * 0.3) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader { geo in
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
                            Text("\(expenses.map( { $0.amount }).reduce(0, +).currency)")
                                .font(.largeTitle)
                                .bold()
                            Image(systemName: "triangle.fill")
                                .rotationEffect(Angle(degrees: 180))
                                .foregroundColor(.orchid)
                        }
                        .scaleEffect(1 - (progress * 0.15))
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: -rect.minX * progress)
                    }
                    .frame(width: size.width - 175 * progress, height: headerHeight * 0.25 * (1 - progress))
                    Text("August 2023").offset(x: size.width * 0.33 * progress,y: -20 * progress)
                }
                .padding(.top, offsetY >= 0.0 ? safeArea.top : safeArea.top + 10)
                .padding(.bottom, 15)
            }
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY))
            .offset(y: -offsetY)
        }.frame(height: headerHeight)
    }
}
