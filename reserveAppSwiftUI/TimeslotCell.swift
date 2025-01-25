//
//  TimeslotCell.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 24.01.2025.
//

import Foundation
import SwiftUI

struct TimeslotCell: View {
    @State var observed: Observed
    var body: some View {
        VStack(alignment:.leading, spacing: 13) {
            Text(observed.timeLable )
        }
        .fontWeight(.bold)
        .font(.title3)
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.greenstatus)
        .clipShape(RoundedRectangle(cornerRadius: 15 ))
        
        .offset(x: 60)
    }
}

extension TimeslotCell{
    @Observable
    class Observed{
        var timeslot: Timeslot
        var timeLable:String { "\(timeslot.startTime.formatted(date: .omitted, time: .shortened)) - \(timeslot.endTime.formatted(date: .omitted, time: .shortened))"}
        
        init(timeslot: Timeslot) {
            self.timeslot = timeslot
        }
    }
}

#Preview(body: {
    TimeslotCell(observed: .init(timeslot: .init(startTime: .now, masterId: UUID())))
})
