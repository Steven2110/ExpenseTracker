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
                    HStack(spacing: 20) {
                        Text("Amount ▲")
                            .padding()
                            .overlay {
                                Capsule(style: .continuous)
                                    .stroke(Color.primaryAccent, lineWidth: 2)
                            }
                            .padding(3)
                        Text("Date ▼")
                            .padding()
                            .overlay {
                                Capsule(style: .continuous)
                                    .stroke(Color.primaryAccent, lineWidth: 2)
                            }
                            .padding(3)
                        Text("All")
                            .padding()
                            .padding(.horizontal)
                            .overlay {
                                Capsule(style: .continuous)
                                    .stroke(Color.primaryAccent, lineWidth: 2)
                            }
                            .padding(3)
                    }.padding(.horizontal)
                }
                .frame(height: 75)
                .offset(y: -offsetY)
            }
        }.frame(height: headerHeight)
    }
}
