


//
//  Date + Extension.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 22.01.2025.
//

import Foundation


extension Date{
    var isToday: Bool {
        Calendar.current.isDateInToday(self) }
    
    var isTheSameHour: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame }
    
    var isPast: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending }
    
    var isFuture: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedDescending }

    func format(format: String)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func fetchWeek(date: Date = Date()) -> [WeekDay] {
        let callendar = Calendar.current
        let startOfDate = callendar.startOfDay(for: date)
        var week: [WeekDay] = []
        let weekForDate = callendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        
        guard let startOfWeek = weekForDate?.start else { return week}
        
        (0..<7).forEach{ index in
            if let weekDayDate = callendar.date(byAdding: .day, value: index, to: startOfWeek){
                week.append(WeekDay(date: weekDayDate))
                }
            }
        return week
        }
    
   func createNextWeek() -> [WeekDay] {
    let calendar = Calendar.current
    let startOfDate = calendar.startOfDay(for: self)
    guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfDate) else { return []}
       return fetchWeek(date: nextDate)
    }
    
    func createPreviousWeek() -> [WeekDay] {
     let calendar = Calendar.current
     let startOfDate = calendar.startOfDay(for: self)
     guard let nextDate = calendar.date(byAdding: .day, value: -1, to: startOfDate) else { return []}
        return fetchWeek(date: nextDate)
     }

    
    
    struct WeekDay: Identifiable{
        var id = UUID()
        var date: Date
        var isChosen: Bool = false
    }
}
