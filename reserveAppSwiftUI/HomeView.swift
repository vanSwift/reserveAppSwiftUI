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
    @State private var weeks: [[Date.WeekDay]] = []
    @State private var createWeek: Bool = true
    @State var chosenDayId: UUID?
    @State var currentWeekIndex = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Header()
                .padding(.horizontal)
                .foregroundStyle(.white)
                .onAppear {
                    week = date.fetchWeek()
                    if let firstDay = week.first?.date{
                        weeks.append(firstDay.createPreviousWeek())
                        weeks.append(week)
                        if let lastDay = week.last?.date{
                            weeks.append(lastDay.createNextWeek())
                        }
                    }
                }

            TabView(selection: $currentWeekIndex) {
                ForEach(weeks.indices, id: \.self){ index in
                    SliderView(week: weeks[index])
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            Spacer()
            
            ScrollView(.vertical) {
            
            }
        }.background(.main)
        
    }
    
    @ViewBuilder
    func Header() -> some View {
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
        }}
    
    @ViewBuilder
    func SliderView(week: [Date.WeekDay]) -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(week, id: \.id) { day in
                VStack(alignment: .center, spacing: 0) {
                    Text(day.date.format(format: "EE"))
                        .fontWeight(.medium)
                    Text(day.date.format(format: "d"))
                        .padding(.vertical, 10)
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
                .offset(y: -130)
                
            }
        }
        .background{GeometryReader{ proxy in
            let minX = proxy.frame(in: .global).minX
            Color
                .clear
                .preference(key: OffsetKey.self, value: minX)
                .onPreferenceChange (OffsetKey.self){ value in
                    if value.rounded() == 15 && createWeek{
                        paginateWeek()
                    }
                }
            
        }
        }
    
        
    }
    func paginateWeek(){
        if weeks.indices.contains(currentWeekIndex){
            if let firstDate = weeks[currentWeekIndex].first?.date,
               currentWeekIndex == 0{
                weeks.insert(firstDate.createPreviousWeek(), at: 0)
                weeks.removeLast()
                currentWeekIndex = 1
            }
        }
        if let lastDate = weeks[currentWeekIndex].last?.date,
           currentWeekIndex == weeks.count - 1{
            weeks.append(lastDate.createNextWeek())
            currentWeekIndex = weeks.count - 2
            
        }
    }
    
}


#Preview{
    HomeView()
}
