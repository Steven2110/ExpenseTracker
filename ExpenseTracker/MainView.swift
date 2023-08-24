//
//  MainView.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 23.08.2023.
//

import SwiftUI

struct MainView: View {
    @State private var offsetY: CGFloat = 0
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets
            ScrollView(showsIndicators: false) {
                VStack {
                    HeaderView(size: size, safeArea: safeArea)
                        .zIndex(1)
                    ForEach(0..<50) { _ in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.primaryAccent.opacity(0.5))
                                .frame(height: 100)
                            HStack {
                                Image(systemName: "airplane")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .rotationEffect(Angle(degrees: -45))
                                    .padding()
                                    .foregroundColor(.yellow)
                                    .background(Color.gray.opacity(0.4))
                                    .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Fly to Paris")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                    Text(getDateFormatted(from: Date())).font(.caption)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Text("$1,300.00")
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
        MainView()
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
                            Text("$ 3,000.00")
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
