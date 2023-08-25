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
                        ExpenseRowView(expense: expense)
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
