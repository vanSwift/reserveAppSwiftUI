//
//  Timeslot.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 24.01.2025.
//

import Foundation

class Timeslot: Identifiable{
    var id: UUID = .init()
    var startTime: Date
    var masterId: UUID
    var clientId: UUID?
    var endTime: Date
    
    init(startTime: Date, masterId: UUID){
        self.startTime = startTime
        self.masterId = masterId
        self.endTime = self.startTime.addingTimeInterval(7200)
    }
}

extension Timeslot{
    static var masterId = UUID()
    static var mockData: [Timeslot] = [Timeslot(startTime: .init(timeIntervalSince1970: 1), masterId: masterId),
                                       Timeslot(startTime: .init(timeIntervalSince1970: 2), masterId: masterId),
                                       Timeslot(startTime: .init(timeIntervalSince1970: 3), masterId: masterId),
                                       Timeslot(startTime: .init(timeIntervalSince1970: 4), masterId: masterId),]
}
