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
    @State private var showProfile: Bool = true
    
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
            .offset(y: -140)
            
            
            
            ScrollView(.vertical) {
                VStack(spacing: 19){
                    ForEach(Timeslot.mockData){ slot in
                        TimeslotCell(observed: .init(timeslot: slot))
                            
                                                
                    }
                    
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            .frame(height: 400)
            .offset(y: -190)
            
        }.background(.main)
            .overlay {
                if showProfile { ProfilePage()
                }
            }
        
    }
    
    @ViewBuilder
    func Header() -> some View {
        HStack(spacing: 0) {
        Text(date.format(format: "LLLL"))
            .font(.title)
            .foregroundStyle(.blue)
            .fontWeight(.bold)
        Text(date.format(format: "YYYY"))
            .font(.title)
            .foregroundStyle(.gray)
            .fontWeight(.bold)
            .padding(.horizontal, 5)
            Spacer()
            
        Image("avatar")
            .resizable()
            .scaledToFill()
            .frame(width: 55, height: 55)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.blue.opacity(0.9),lineWidth: 1))
            .onTapGesture {
                showProfile = true
            }
                    
            
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
                        .padding(.vertical)
                 
                    Text(day.date.format(format: "d"))
                        .padding(.vertical, 10)
                        .onAppear {
                            if day.date.isToday {
                                chosenDayId = day.id
                            }
                        }
                       // .padding(.vertical, 10)
                        .fontWeight(.bold)
                        .onTapGesture {
                            
                            chosenDayId = day.id
                            date = day.date
                        }
                        .foregroundStyle(
                            day.id == chosenDayId ? .white : .gray)
                        .background {
                            if day.id == chosenDayId {
                                Circle().frame(width: 36, height: 36)
                                    .foregroundStyle(.blue)
                                
                            }
                            else{Circle()
                                    .stroke(Color.gray.opacity(0.2))
                                    .frame(width: 36, height: 36)
                                    //.foregroundStyle(.gray)
                                    }
                            if day.date.isToday {
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundStyle(.red)
                                    .offset(y: 25)
                            }
                        }
                }
                .padding(.vertical)
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 130)
                .padding(.vertical, 30)
              //  .offset(y: -170)
                
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

struct ProfilePage: View {
  @State private var profileName = "Бусінка"
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 50, bottomLeading: 50, bottomTrailing: 80, topTrailing: 0), style: .circular)
                .fill(.white)
                .padding(.init(top: 100, leading: 25, bottom: 180, trailing: 25) )
                
            VStack{
                Image("avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .background{Circle().stroke(Color.white, lineWidth: 30)}
                
                TextField("Ваше імʼя", text: $profileName).font(.title.bold())
                
                
                Spacer()
                
            }
            .padding(.init(top: 30, leading: 60, bottom: 180, trailing: 60) )
                
        }
    }
}



#Preview{
    HomeView()
}
