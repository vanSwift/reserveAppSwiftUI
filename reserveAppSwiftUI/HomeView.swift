//
//  HomeView.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 23.01.2025.
//

import Foundation
import SwiftUI



struct HomeView: View {
    
    @State private var date: Date = .init()
    @State private var week: [Date.WeekDay] = []
    @State var chosenDayId: UUID?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(date.format(format: "MMMM"))
                    .font(.title)
                    .foregroundStyle(.blue)
                    .fontWeight(.bold)
                Text(date.format(format: "YYYY"))
                    .font(.title)
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
                    .padding(.horizontal, 5)
            }
            
            Text(date.format(format: "EEEE, d MMMM, yyyy"))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .padding(.vertical, 5)
                .onAppear { week.append(contentsOf: date.fetchWeek())
                }

            SliderView()
            
            ScrollView(.vertical) {
            
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func SliderView() -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(week, id: \.id) { day in
                VStack(alignment: .center, spacing: 0) {
                    Text(day.date.format(format: "EE"))
                        .fontWeight(.medium)
                    Text(day.date.format(format: "d"))
                        .onAppear {
                            if day.date.isToday {
                                chosenDayId = day.id
                            }
                        }
                        .padding(.vertical, 10)
                        .fontWeight(.bold)
                        .onTapGesture {
                            chosenDayId = day.id
                        }
                        .foregroundStyle(
                            day.id == chosenDayId ? .white : .gray)
                        .background {
                            if day.id == chosenDayId {
                                Circle().frame(width: 36, height: 36)
                                    .foregroundStyle(.blue)
                            }
                            if day.date.isToday {
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundStyle(.red)
                                    .offset(y: 25)
                            }
                        }
                }
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
        }
//        .gesture(
//            DragGesture().onEnded { value in
//                if value.translation.width < 0 {
//                    // Смахивание вправо
//                    if let lastWeek = weeks.wrappedValue.last {
//                        weeks.wrappedValue.insert(lastWeek.createNextWeek(), at: 0)
//                        weeks.wrappedValue.removeLast()
//                    }
//                } else if value.translation.width > 0 {
//                    // Смахивание влево
//                    if let firstWeek = weeks.wrappedValue.first {
//                        weeks.wrappedValue.append(firstWeek.createPreviousWeek())
//                        weeks.wrappedValue.removeFirst()
//                    }
//                }
//            }
//        )
    }
}


#Preview{
    HomeView()
}
